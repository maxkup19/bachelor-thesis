//
//  AuthError.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum AuthError: Error, Equatable {
    case login(Login)
    case registration(Registration)
    
    public enum Login {
        case invalidCredentials
        case failed
    }
    
    public enum Registration {
        case userAlreadyExists
        case failed
    }
}
