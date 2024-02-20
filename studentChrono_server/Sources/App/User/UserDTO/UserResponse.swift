//
//  UserResponse.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

struct UserResponse: Content {
    var name: String
    var lastname: String
    var email: String
    var role: UserRoleEnum
}

extension User {
    var asUserResponse: UserResponse {
        UserResponse(
            name: name,
            lastname: lastname,
            email: email,
            role: role
        )
    }
}
