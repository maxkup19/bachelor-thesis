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
        let tasks = routes
            .grouped(Configuration.baseApi)
            .grouped(TaskRoutes.base)
            .grouped(Token.authenticator())
        
        tasks.get(use: index)
        tasks.post(use: createTask)
    }
    
    private func index(req: Request) async throws -> [TaskResponse] {
        return try await Task.query(on: req.db)
            .with(\.$author)
            .with(\.$assignee)
            .all()
            .map { $0.asTaskResponse }
    }
    
    private func createTask(req: Request) async throws -> HTTPStatus {
        let createTaskDTO = try req.content.decode(CreateTaskDTO.self)
        
        guard try await checkIfUserExists(id: createTaskDTO.authorId, on: req.db) else {
            throw Abort(.notFound, reason: "Author ID doesn't exist")
        }
        
        if let assigneeId = createTaskDTO.assigneeId {
            guard try await checkIfUserExists(id: assigneeId, on: req.db) else {
                throw Abort(.notFound, reason: "Assignee ID doesn't exist")
            }
        }
        
        let task = createTaskDTO.asTask()
        try await task.save(on: req.db)
        
        return .ok
    }
    
    private func checkIfUserExists(id: UUID, on db: Database) async throws -> Bool {
        try await User.query(on: db)
            .filter(\.$id, .equal, id)
            .count() != 0
    }
}
