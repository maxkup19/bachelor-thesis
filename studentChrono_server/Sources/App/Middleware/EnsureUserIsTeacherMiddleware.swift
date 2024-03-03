//
//  EnsureUserIsTeacherMiddleware.swift
//
//
//  Created by Maksym Kupchenko on 25.02.2024.
//

import Vapor

struct EnsureUserIsTeacherMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard let user = request.auth.get(User.self),
              user.role == .teacher else {
            throw Abort(.forbidden, reason: "Teacher role required, yout role is \(request.auth.get(User.self)?.role)")
        }
        return try await next.respond(to: request)
    }
}
