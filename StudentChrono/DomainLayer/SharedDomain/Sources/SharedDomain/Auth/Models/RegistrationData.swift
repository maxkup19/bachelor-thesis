//
//  RegistrationData.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public struct RegistrationData: Equatable {
    public let email: String
    public let password: String
    public let name: String
    public let lastName: String
    public let role: UserRoleEnum.RawValue
    
    public init(
        email: String,
        password: String,
        name: String,
        lastName: String,
        role: UserRoleEnum
    ) {
        self.email = email
        self.password = password
        self.name = name
        self.lastName = lastName
        self.role = role.rawValue
    }
}
