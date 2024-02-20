//
//  UserController.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("\(UserRoutes.users)")
        
        users.get(use: index)
        users.post("\(UserRoutes.Options.signup)" , use: create) // payload in body
        users.post("\(UserRoutes.Options.login)", use: login)
        
        // Bearer token
        let tokenProtected = users.grouped(Token.authenticator())
        tokenProtected.get("\(UserRoutes.Options.me)", use: getMe)
        
    }
    
    func index(req: Request) async throws -> [User.Public] {
        return try await User.query(on: req.db).all().map { $0.asPublic() }
    }
    
    fileprivate func create(req: Request) async throws -> User.NewSession {
        try User.CreateUserDTO.validate(content: req)
        let createUserDTO = try req.content.decode(User.CreateUserDTO.self)
        
        let user = try createUserDTO.asUserModel()
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
        
        return User.NewSession(token: token.value, userId: try user.requireID().uuidString)
    }
    
    fileprivate func login(req: Request) async throws -> User.NewSession {
        let loginUserDTO = try req.content.decode(User.LoginUserDTO.self)
        
        let encryptedPassword = try Bcrypt.hash(loginUserDTO.password)
        
        guard let user = try await getUserByEmail(loginUserDTO.email, req: req),
              try Bcrypt.verify(loginUserDTO.password, created: user.password) else {
            throw Abort(.badRequest, reason: "Check Your login and password!")
        }
        
        if let token = try await Token.query(on: req.db)
            .filter(\.$user.$id, .equal, user.requireID())
            .filter(\.$expiresAt, .greaterThan, Date())
            .first() {
            return User.NewSession(token: token.value, userId: try user.requireID().uuidString)
        } else {
            try await Token.query(on: req.db)
                .filter(\.$user.$id, .equal, user.requireID())
                .filter(\.$expiresAt, .lessThan, Date())
                .delete()
        }
        
        let token = try user.createToken(source: .login)
        
        try await token.save(on: req.db)
        
        return User.NewSession(token: token.value, userId: try user.requireID().uuidString)
    }
    
    fileprivate func getMe(req: Request) async throws -> User.Public {
        try req.auth.require(User.self).asPublic()
    }
    
    
    private func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
}
