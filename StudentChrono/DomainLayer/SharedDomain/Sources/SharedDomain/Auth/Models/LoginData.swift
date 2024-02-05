//
//  LoginData.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public struct LoginData: Equatable {
    public let email: String
    public let password: String
    
    public init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
}
