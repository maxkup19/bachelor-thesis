//
//  SignupDTO.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import Vapor

struct SignupDTO: Content {
    var name: String
    var lastName: String
    var email: String
    var password: String
    var birthDay: Date
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
            lastName: lastName,
            email: email,
            password: try Bcrypt.hash(password),
            birthDay: birthDay,
            role: role
        )
    }
}
