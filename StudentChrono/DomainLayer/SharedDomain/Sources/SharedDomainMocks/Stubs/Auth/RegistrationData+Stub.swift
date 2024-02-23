//
//  RegistrationData+Stubs.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

public extension RegistrationData {
    static let stubValid = RegistrationData(
        email: "email@email.com",
        password: "password",
        name: "Anonymous",
        lastName: "",
        birthDay: .distantPast
    )
    
    static let stubEmptyEmail = RegistrationData(
        email: "",
        password: "password",
        name: "Anonymous",
        lastName: "",
        birthDay: .distantPast
    )
    
    static let stubEmptyPassword = RegistrationData(
        email: "email@email.com",
        password: "",
        name: "Anonymous",
        lastName: "",
        birthDay: .distantPast
    )
}

