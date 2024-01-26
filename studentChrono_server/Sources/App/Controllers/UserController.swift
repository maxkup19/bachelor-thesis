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
        users.post("\(UserRoutes.Options.signup)" , use: create)
        
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
        
        guard try await !checkIfUserExists(user.email, req: req) else {
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
    
    
    private func checkIfUserExists(_ email: String, req: Request) async throws -> Bool {
        let user = try await User
            .query(on: req.db)
            .filter(\.$email, .equal, email)
            .first()
        
        print(user)
        
        return user != nil
        
    }
}
