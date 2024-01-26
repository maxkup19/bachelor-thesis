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
        
        // username and password in basic authorization
        let passwordProtected = users.grouped(User.authenticator())
        passwordProtected.post("\(UserRoutes.Options.login)", use: login)
        
    }
    
    func index(req: Request) async throws -> [User.Public] {
        return try await User.query(on: req.db).all().map { $0.asPublic() }
    }
    
    fileprivate func create(req: Request) async throws -> User.NewSession {
        try User.CreateUserDTO.validate(content: req)
        let createUserDTO = try req.content.decode(User.CreateUserDTO.self)
        
        guard createUserDTO.password == createUserDTO.confirmPassword else {
            throw Abort(.notAcceptable, reason: "Password are not the same!")
        }
        
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
        
        return User.NewSession(token: token.value, user: user.asPublic())
    }
    
    fileprivate func login(req: Request) async throws -> User.NewSession {
        let loggedUser = try req.auth.require(User.self)
        guard let user = try await getUserByEmail(loggedUser.email, req: req) else {
            throw Abort(.badRequest, reason: "User doesn't exist")
        }
        let token = try user.createToken(source: .login)
        
        try await token.save(on: req.db)
        
        return User.NewSession(token: token.value, user: user.asPublic())
    }
    
    
    private func getUserByEmail(_ email: String, req: Request) async throws -> User? {
        return try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
    }
}
