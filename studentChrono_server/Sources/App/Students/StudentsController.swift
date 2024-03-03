//
//  StudentsController.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Vapor
import Fluent

struct StudentsController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let studentsRoutes = routes
            .grouped(Configuration.baseApi)
            .grouped(StudentsRoutes.base)
            .grouped(Token.authenticator())
            .grouped(EnsureUserIsTeacherMiddleware())
        
        studentsRoutes.patch(use: addStudent)
        
    }
    
    private func addStudent(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let addStudentDTO = try req.content.decode(AddStudentDTO.self)
        try await ensureUserExists(id: addStudentDTO.studentId, on: req.db)
        
        user.studentIds.append(addStudentDTO.studentId)
        try await user.update(on: req.db)
        
        return .ok
    }
    
}


// MARK: - Helpers

private extension StudentsController {
    func ensureUserExists(id: UUID, on db: Database) async throws {
        guard try await User.query(on: db)
            .filter(\.$id, .equal, id)
            .count() != 0 else {
            throw Abort(.notFound, reason: "User with id \(id) doesn't exist")
        }
    }
}
