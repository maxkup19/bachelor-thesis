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
        
        userRoutes.patch(UserRoutes.image, use: uploadImage)
        userRoutes.delete(UserRoutes.image, use: deleteImage)
        
        userRoutes.patch(UserRoutes.info, use: updateInfo)
        
        // MARK: - the only reason it's not get request is iOS doesn't allow to send request with body
        userRoutes.post(UserRoutes.password, use: verifyPassword)
        userRoutes.patch(UserRoutes.password, use: updatePassword)
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
        if let tasks = try? await Task.query(on: req.db)
            .with(\.$author)
            .filter(\.$author.$id, .equal, try user.requireID())
            .all() {
            try await tasks.delete(on: req.db)
        }
        
        try await user.delete(on: req.db)
        
        return .ok
    }
    
    private func uploadImage(req: Request) async throws -> User {
        let user = try req.auth.require(User.self)
        let file = try req.content.decode(File.self)
        
        user.imageURL = file.fileName
        try await user.update(on: req.db)
        
        return user
    }
    
    private func deleteImage(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        
        try deleteUserImageFromServer(user: user, req: req)
        user.imageURL = nil
        try await user.update(on: req.db)
        
        return .ok
    }
    
    private func updateInfo(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let updateInfoDTO = try req.content.decode(UpdateUserInfoDTO.self)
        
        user.name = updateInfoDTO.name ?? user.name
        user.lastName = updateInfoDTO.lastName ?? user.lastName
        user.birthDay = updateInfoDTO.birthDay ?? user.birthDay
        
        try await user.update(on: req.db)
        return .ok
    }
    
    private func verifyPassword(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let password = try req.content.decode(PasswordDTO.self).password
        
        guard try Bcrypt.verify(password, created: user.password) else {
            throw Abort(.expectationFailed, reason: "Incorrect password")
        }
        
        return .ok
    }
    
    private func updatePassword(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let newPassword = try req.content.decode(PasswordDTO.self).password
        
        user.password = try Bcrypt.hash(newPassword)
        try await user.update(on: req.db)
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
    
    private func deleteUserImageFromServer(user: User, req: Request) throws {
        if let prevImage = user.imageURL {
            let prevPath = req.application.directory.publicDirectory + (prevImage.split(separator: "/").last ?? "")
            try FileManager.default.removeItem(atPath: prevPath)
        }
    }
}
