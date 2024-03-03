//
//  User.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation

public struct User: Equatable, Codable, Identifiable, Hashable {
    public let id: String
    public let name: String
    public let lastName: String
    public let email: String
    public let role: UserRoleEnum
    public let birthDay: Date
    
    
    public init(
        id: String,
        name: String,
        lastName: String,
        email: String,
        role: UserRoleEnum,
        birthDay: Date
    ) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.email = email
        self.role = role
        self.birthDay = birthDay
    }
}
