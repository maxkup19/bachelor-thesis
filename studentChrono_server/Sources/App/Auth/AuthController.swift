//
//  AuthController.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

struct AuthController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let authRoutes = routes
            .grouped(Configuration.baseApi)
            .grouped(AuthRoutes.base)
        
        
        authRoutes.post(AuthRoutes.signup, use: create)
        authRoutes.post(AuthRoutes.login, use: login)
    }
    
    private func create(req: Request) async throws -> AuthResponse {
        try SignupDTO.validate(content: req)
        let signupDTO = try req.content.decode(SignupDTO.self)
        
        let user = try signupDTO.asUserModel()
        var token: Token!
        
        guard try await getUserByEmail(user.email, req: req) == nil else {
            throw Abort(.badRequest, reason: "User already exists!")
        }
        
        try await user.save(on: req.db)
        
        guard let newToken = try? user.createToken(source: .signup) else {
            throw Abort(.internalServerError)
        }
        
        token = newToken
        try await token.save(on: req.db)
        
        return AuthResponse(
            userId: try user.requireID().uuidString,
            token: token.value
        )
    }
    
    private func login(req: Request) async throws -> AuthResponse {
        let loginDTO = try req.content.decode(LoginDTO.self)
        
        guard let user = try await getUserByEmail(loginDTO.email, req: req),
              try Bcrypt.verify(loginDTO.password, created: user.password) else {
            throw Abort(.badRequest, reason: "Check Your login and password!")
        }
        
        if let token = try await Token.query(on: req.db)
            .filter(\.$user.$id, .equal, user.requireID())
            .filter(\.$expiresAt, .greaterThan, Date())
            .first() {
            return AuthResponse(
                userId: try user.requireID().uuidString,
                token: token.value
            )
        } else {
            try await Token.query(on: req.db)
                .filter(\.$user.$id, .equal, user.requireID())
                .filter(\.$expiresAt, .lessThan, Date())
                .delete()
        }
        
        let token = try user.createToken(source: .login)
        
        try await token.save(on: req.db)
        
        return AuthResponse(userId: try user.requireID().uuidString, token: token.value)
    }
    
    private func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
    
}
