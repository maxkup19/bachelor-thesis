//
//  SignupDTO.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

struct SignupDTO: Content {
    var name: String
    var lastname: String
    var email: String
    var password: String
    var role: UserRoleEnum
}

extension SignupDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension SignupDTO {
    func asUserModel() throws -> User {
        User(
            name: name,
            lastname: lastname,
            email: email,
            password: try Bcrypt.hash(password),
            role: role
        )
    }
}
