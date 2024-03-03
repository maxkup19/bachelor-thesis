//
//  RegistrationData.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public struct RegistrationData: Equatable {
    public let email: String
    public let password: String
    public let name: String
    public let lastName: String
    public let birthDay: Date
    public let role: UserRoleEnum
    
    public init(
        email: String,
        password: String,
        name: String,
        lastName: String,
        birthDay: Date,
        role: UserRoleEnum
    ) {
        self.email = email
        self.password = password
        self.name = name
        self.lastName = lastName
        self.birthDay = birthDay
        self.role = role
    }
}
