//
//  User.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

public struct User: Equatable {
    public let name: String
    public let lastname: String
    public let email: String
    public let role: UserRoleEnum
    
    
    public init(
        name: String,
        lastname: String,
        email: String,
        role: UserRoleEnum
    ) {
        self.name = name
        self.lastname = lastname
        self.email = email
        self.role = role
    }
}
