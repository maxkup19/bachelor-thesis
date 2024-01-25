//
//  UserDTO.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent
import Vapor

extension User {
    struct CreateUserDTO: Content {
        var name: String?
        var lastname: String?
        var email: String
        var password: String
        var confirmPassword: String
        var role: UserRoleEnum.RawValue
    }
    
    struct UpdateUserDTO: Content {
        var name: String?
        var lastname: String?
    }
}

extension User.CreateUserDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension User.CreateUserDTO {
    var asUserModel: User {
        User(
            name: name,
            lastname: lastname,
            email: email,
            password: password,
            role: role
        )
    }
}
