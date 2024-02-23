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
    var lastname: String
    var email: String
    var birtDay: Date
    var role: UserRoleEnum
}

extension User {
    var asUserResponse: UserResponse {
        UserResponse(
            name: name,
            lastname: lastname,
            email: email,
            birtDay: birthDay,
            role: role
        )
    }
}
