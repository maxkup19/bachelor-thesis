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
        var role: UserRoleEnum.RawValue
    }
    
    struct UpdateUserDTO: Content {
        var name: String?
        var lastname: String?
    }
    
    struct Public: Content {
        var name: String
        var lastname: String
        var email: String
        var role: UserRoleEnum.RawValue
    }
    
    struct NewSession: Content {
        var token: String
        var userId: String
    }
}

extension User.CreateUserDTO: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

extension User.CreateUserDTO {
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

extension User {
    func asPublic() -> Public {
        Public(
            name: name ?? "",
            lastname: lastname ?? "",
            email: email,
            role: role
        )
    }
    
    func createToken(source: SessionSourceEnum) throws -> Token {
      let calendar = Calendar(identifier: .gregorian)
      let expiryDate = calendar.date(byAdding: .year, value: 4, to: Date())
      return try Token(
        userId: requireID(),
        token: [UInt8].random(count: 16).base64,
        source: source.rawValue,
        expiresAt: expiryDate
      )
    }
}
