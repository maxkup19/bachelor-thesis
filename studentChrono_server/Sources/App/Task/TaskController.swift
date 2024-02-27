//
//  TaskController.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Fluent
import Vapor

struct TaskController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let taskRoutes = routes
            .grouped(Configuration.baseApi)
            .grouped(TaskRoutes.base)
            .grouped(Token.authenticator())
        
        taskRoutes.get(use: index)
        
        let teacherRoutes = taskRoutes.grouped(EnsureUserIsTeacherMiddleware())
        teacherRoutes.post(use: createTask)
    }
    
    private func index(req: Request) async throws -> [TaskResponse] {
        let user = try req.auth.require(User.self)
        return try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .all()
            .filter{ $0.assignee?.id == user.id || $0.author.id == user.id }
            .map { $0.asTaskResponse }
    }
    
    private func createTask(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let createTaskDTO = try req.content.decode(CreateTaskDTO.self)
        
        if let assigneeId = createTaskDTO.assigneeId {
            try await ensureUserExists(id: assigneeId, on: req.db)
        }
        
        let task = createTaskDTO.asTask(authorId: try user.requireID())
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
