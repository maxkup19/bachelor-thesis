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
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubEmptyEmail = RegistrationData(
        email: "",
        password: "password",
        firstName: "Anonymous",
        lastName: ""
    )
    
    static let stubEmptyPassword = RegistrationData(
        email: "email@email.com",
        password: "",
        firstName: "Anonymous",
        lastName: ""
    )
}

