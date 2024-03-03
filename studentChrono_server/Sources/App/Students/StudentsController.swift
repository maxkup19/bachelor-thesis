//
//  StudentsController.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Foundation
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
        studentsRoutes.get(StudentsRoutes.mine, use: getMine)
        studentsRoutes.get(StudentsRoutes.nonMine, use: getNonMine)
    }
    
    private func addStudent(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let addStudentDTO = try req.content.decode(AddStudentDTO.self)
        
        guard let addStudent = try await getUserByEmail(addStudentDTO.email, req: req) else {
            throw Abort(.internalServerError, reason: "User dont exist")
        }
        
        guard try user.requireID() != addStudent.requireID() else {
            throw Abort(.conflict, reason: "Teacher and student must be different")
        }
        guard !user.studentIds.contains(try addStudent.requireID()) else {
            throw Abort(.alreadyReported, reason: "This user is already your student")
        }
        
        user.studentIds.append(try addStudent.requireID())
        try await user.update(on: req.db)
        
        return .ok
    }
    
    private func getMine(req: Request) async throws -> [UserResponse] {
        let me = try req.auth.require(User.self)
        
        return try await User.query(on: req.db)
            .filter(\.$id ~~ me.studentIds)
            .all()
            .map(\.asUserResponse)
    }
    
    private func getNonMine(req: Request) async throws -> [UserResponse] {
        let me = try req.auth.require(User.self)
        
        return try await User.query(on: req.db)
            .filter(\.$id !~ me.studentIds)
            .all()
            .map(\.asUserResponse)
    }
    
}


// MARK: - Helpers

private extension StudentsController {
    
    func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
}
