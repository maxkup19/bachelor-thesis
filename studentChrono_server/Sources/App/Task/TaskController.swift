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
        return try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .all()
            .map { $0.asTaskResponse }
    }
    
    #warning("TODO: use auth to get creator of task")
    private func createTask(req: Request) async throws -> HTTPStatus {
        let createTaskDTO = try req.content.decode(CreateTaskDTO.self)
        
        try await ensureUserExists(id: createTaskDTO.authorId, on: req.db)
        
        if let assigneeId = createTaskDTO.assigneeId {
            try await ensureUserExists(id: assigneeId, on: req.db)
        }
        
        let task = createTaskDTO.asTask()
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
