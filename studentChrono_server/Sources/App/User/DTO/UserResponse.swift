//
//  UserResponse.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import Vapor

struct UserResponse: Content {
    var id: String
    var name: String
    var lastName: String
    var email: String
    var birthDay: Date
    var role: UserRoleEnum
    var studentIds: [String]?
}

extension User {
    var asUserResponse: UserResponse {
        UserResponse(
            id: id?.uuidString ?? "",
            name: name,
            lastName: lastName,
            email: email,
            birthDay: birthDay,
            role: role,
            studentIds: role == .teacher ? studentIds.map(\.uuidString) : nil
        )
    }
}
