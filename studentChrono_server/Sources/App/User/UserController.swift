//
//  UserController.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let userRoutes = routes
            .grouped(Configuration.baseApi)
            .grouped(UserRoutes.base)
            .grouped(Token.authenticator())
        
        userRoutes.get(use: index)
        userRoutes.get(UserRoutes.me, use: getMe)
        userRoutes.delete(UserRoutes.deleteAccount, use: deleteAccount)
        
    }
    
    private func index(req: Request) async throws -> [UserResponse] {
        try await User.query(on: req.db)
            .all()
            .map { $0.asUserResponse }
    }
    
    private func getMe(req: Request) async throws -> UserResponse {
        try req.auth.require(User.self).asUserResponse
    }
    
    private func deleteAccount(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        try await user.delete(on: req.db)
        return .ok
    }
}

// MARK: - Helpers

private extension UserController {
    func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
}
