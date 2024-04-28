//
//  TaskController.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Foundation
import Fluent
import Vapor

struct TaskController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let taskRoutes = routes
            .grouped(Configuration.baseApi)
            .grouped(TaskRoutes.base)
            .grouped(Token.authenticator())
        
        taskRoutes.get(TaskRoutes.my, use: index)
        taskRoutes.get(use: getTaskById)
        taskRoutes.post(TaskRoutes.message, use: addMessageToTask)
        taskRoutes.post(TaskRoutes.state, use: changeTaskState)
        
        let teacherRoutes = taskRoutes.grouped(EnsureUserIsTeacherMiddleware())
        teacherRoutes.post(use: createTask)
        teacherRoutes.patch(use: updateTask)
        teacherRoutes.get(TaskRoutes.all, use: getTasksForStudentId)
    }
    
    private func index(req: Request) async throws -> [TaskResponse] {
        let user = try req.auth.require(User.self)
        return try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .all()
            .filter{ $0.assignee?.id == user.id || $0.author.id == user.id }
            .map { $0.asTaskResponse(comments: []) }
    }
    
    private func getTaskById(req: Request) async throws -> TaskResponse {
        guard let id = UUID(req.headers.first(name: TaskRoutes.Parameter.taskId) ?? "") else { throw Abort(.badRequest)
        }
        
        guard let task = try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .filter(\.$id, .equal, id)
            .first() else {
            throw Abort(.notFound)
        }
        
        let comments = try await Message.query(on: req.db)
            .with(\.$author)
            .filter(\.$id ~~ task.comments)
            .all()
            .map(\.asResponse)
        
        return task.asTaskResponse(comments: comments)
    }
    
    private func addMessageToTask(req: Request) async throws -> TaskResponse {
        let author = try req.auth.require(User.self)
        let addMessageDTO = try req.content.decode(AddMessageToTaskDTO.self)
        
        guard
            let taskId = UUID(addMessageDTO.taskId),
            let task = try await Task.query(on: req.db)
                .with(\.$author)
                .with(\.$assignee)
                .filter(\.$id, .equal, taskId)
                .first(),
            try task.author.requireID() == author.requireID()  || task.assignee?.requireID() == author.requireID()
        else { throw Abort(.badRequest) }
        
        var fileURL: String?
        
        if let file = addMessageDTO.file {
            let hashedFileName = try Bcrypt.hash(file.filename).replacingOccurrences(of: "/", with: "")
            let path = req.application.directory.publicDirectory + hashedFileName
            
            try await req.fileio.writeFile(file.data, at: path)
            
            let serverConfig = req.application.http.server.configuration
            let hostname = serverConfig.hostname
            let port = serverConfig.port
            
            fileURL = hashedFileName
            guard ["jpeg", "png", "jpg", "pdf"].contains(file.extension) else {
                throw Abort(.badRequest, reason: "Invalid file format")
            }
        }
        
        let message = Message(
            authorId: try author.requireID(),
            text: addMessageDTO.text,
            file: fileURL
        )
        
        try await message.save(on: req.db)
        task.comments.append(try message.requireID())
        
        if try author.requireID() == task.assignee?.requireID() && task.state != .review {
            task.state = .inProgress
        }
        try await task.save(on: req.db)
        
        let comments = try await Message.query(on: req.db)
            .with(\.$author)
            .filter(\.$id ~~ task.comments)
            .all()
            .map(\.asResponse)
        
        return task.asTaskResponse(comments: comments)
    }
    
    private func changeTaskState(req: Request) async throws -> TaskResponse {
        let user = try req.auth.require(User.self)
        let changeTaskStateDTO = try req.content.decode(ChangeTaskStateDTO.self)
        
        guard (changeTaskStateDTO.taskState == .done && user.role == .teacher) ||
                (changeTaskStateDTO.taskState == .review) && user.role == .student
        else {
            throw Abort(.badRequest, reason: "Invalid user roles")
        }
        
        guard
            let taskId = UUID(changeTaskStateDTO.taskId),
            let task = try await Task.query(on: req.db)
                .with(\.$author)
                .with(\.$assignee)
                .filter(\.$id, .equal, taskId)
                .first()
        else {
            throw Abort(.badRequest, reason: "Task does not exist!")
        }
        
        task.state = changeTaskStateDTO.taskState
        try await task.save(on: req.db)
        
        let comments = try await Message.query(on: req.db)
            .with(\.$author)
            .filter(\.$id ~~ task.comments)
            .all()
            .map(\.asResponse)
        
        return task.asTaskResponse(comments: comments)
    }
    
    private func getTasksForStudentId(req: Request) async throws -> [TaskResponse] {
        let user = try req.auth.require(User.self)
        guard let studentId = UUID(req.headers.first(name: TaskRoutes.Parameter.studentId) ?? "") else { throw Abort(.badRequest)
        }
        
        return try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .filter(\.$assignee.$id, .equal, studentId)
            .filter(\.$author.$id, .equal, user.requireID())
            .all()
            .map { $0.asTaskResponse(comments: [])}
    }
    
    private func createTask(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let createTaskDTO = try req.content.decode(CreateTaskDTO.self)
        var assigneeId: UUID?
        
        if let id = createTaskDTO.assigneeId {
            assigneeId = UUID(id)
        }
        
        if let assigneeId  {
            try await ensureUserExists(id: assigneeId, on: req.db)
        }
        
        let task = createTaskDTO.asTask(
            authorId: try user.requireID(),
            assigneeId: assigneeId
        )
        
        try await task.save(on: req.db)
        return .ok
    }
    
    private func updateTask(req: Request) async throws -> HTTPStatus {
        let updateTaskDTO = try req.content.decode(UpdateTaskDTO.self)
        guard
            let taskId = UUID(updateTaskDTO.taskId),
            let task = try await Task.query(on: req.db)
                .filter(\.$id, .equal, taskId)
                .first()
        else {
            throw Abort(.badRequest, reason: "Task does not exist!")
        }
        
        task.title = updateTaskDTO.title
        task.description = updateTaskDTO.description
        task.tags = updateTaskDTO.tags
        task.dueTo = updateTaskDTO.dueTo
        task.priority = updateTaskDTO.priority
        
        if let assigneeId = updateTaskDTO.assigneeId,
           let assignee = UUID(assigneeId) {
            task.$assignee.id = assignee
            task.state = .todo
        }
        
        try await task.save(on: req.db)
        
        return .ok
    }
}

// MARK: - Helpers

private extension TaskController {
    func ensureUserExists(id: UUID, on db: Database) async throws {
        guard try await User.query(on: db)
            .filter(\.$id, .equal, id)
            .count() != 0 else {
            throw Abort(.notFound, reason: "User with id \(id) doesn't exist")
        }
    }
}
