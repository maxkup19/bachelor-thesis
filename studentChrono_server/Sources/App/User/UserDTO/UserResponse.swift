//
//  UserResponse.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import Vapor

struct UserResponse: Content {
    var name: String
    var lastName: String
    var email: String
    var birthDay: Date
    var role: UserRoleEnum
}

extension User {
    var asUserResponse: UserResponse {
        UserResponse(
            name: name,
            lastName: lastName,
            email: email,
            birthDay: birthDay,
            role: role
        )
    }
}
