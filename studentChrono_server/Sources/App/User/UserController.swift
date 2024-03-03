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
        userRoutes.patch(UserRoutes.me, use: uploadImage)
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
    
    private func uploadImage(req: Request) async throws -> HTTPStatus {
        let user = try req.auth.require(User.self)
        let file = try req.content.decode(File.self)
        
        if let prevImage = user.imageURL {
            let prevPath = req.application.directory.publicDirectory + (prevImage.split(separator: "/").last ?? "")
            try FileManager.default.removeItem(atPath: prevPath)
        }
        
        let hashedFileName = try Bcrypt.hash(file.filename).replacingOccurrences(of: "/", with: "")
        let path = req.application.directory.publicDirectory + hashedFileName
        
        try await req.fileio.writeFile(file.data, at: path)
        
        let serverConfig = req.application.http.server.configuration
        let hostname = serverConfig.hostname
        let port = serverConfig.port
        user.imageURL = "http://\(hostname):\(port)/\(hashedFileName)"
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
}
