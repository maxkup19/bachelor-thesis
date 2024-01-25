//
//  UserController.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

struct UserController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("\(RoutesEnum.Users.users.rawValue)")
        
        users.get(use: index)
        users.post(use: create)
        
    }
    
    func index(req: Request) async throws -> [User] {
        return try await User.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> User {
        try User.CreateUserModelDTO.validate(content: req)
        let newUser = try req.content.decode(User.CreateUserModelDTO.self)
        
        guard newUser.password == newUser.confirmPassword else {
            throw Abort(.notAcceptable, reason: "Password are not the same!")
        }
        
        let user = newUser.asUserModel
        try await user.save(on: req.db)
        
        return user
    }
    
}
