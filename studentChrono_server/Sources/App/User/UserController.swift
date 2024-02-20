//
//  UserController.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let users = routes
            .grouped(Configuration.baseApi)
            .grouped(UserRoutes.base)
        
        // Bearer token
        let tokenProtected = users.grouped(Token.authenticator())
        tokenProtected.get(use: index)
        tokenProtected.get(UserRoutes.me, use: getMe)
        
    }
    
    private func index(req: Request) async throws -> [UserResponse] {
        return try await User.query(on: req.db).all().map { $0.asUserResponse }
    }
    
    private func getMe(req: Request) async throws -> UserResponse {
        try req.auth.require(User.self).asUserResponse
    }
    
    private func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
}
