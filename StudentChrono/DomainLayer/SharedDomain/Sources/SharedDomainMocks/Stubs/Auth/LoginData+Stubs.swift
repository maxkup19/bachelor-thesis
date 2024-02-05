//
//  LoginData+Stubs.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

public extension LoginData {
    static let stubValid = LoginData(email: "email@email.com", password: "password")
    static let stubEmptyEmail = LoginData(email: "", password: "password")
    static let stubEmptyPassword = LoginData(email: "email@email.com", password: "")
}
