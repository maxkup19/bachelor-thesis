//
//  StudentsController.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Vapor

struct StudentsController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let studentsRoutes = routes
            .grouped(StudentsRoutes.base)
            .grouped(EnsureUserIsTeacherMiddleware())
            .grouped(Token.authenticator())
        
        studentsRoutes.get(use: getMyStudents)
    }
    
    private func getMyStudents(req: Request) async throws -> [UserResponse] {
        return []
    }
    
}
