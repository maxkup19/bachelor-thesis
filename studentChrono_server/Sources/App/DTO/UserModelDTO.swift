//
//  UserModelDTO.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent
import Vapor

extension UserModel {
    struct CreateUserModelDTO: Content {
        var name: String?
        var lastname: String?
        var email: String
        var password: String
        var confirmPassword: String
        var role: UserRoleEnum.RawValue
    }
    
    struct UpdateUserModelDTO: Content {
        var name: String?
        var lastname: String?
    }
}

extension UserModel.CreateUserModelDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension UserModel.CreateUserModelDTO {
    var asUserModel: UserModel {
        UserModel(
            name: name,
            lastname: lastname,
            email: email,
            password: password,
            role: role
        )
    }
}
