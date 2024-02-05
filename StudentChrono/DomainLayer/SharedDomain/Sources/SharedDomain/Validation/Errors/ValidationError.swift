//
//  ValidationError.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum ValidationError: Error, Equatable {
    case email(Email)
    case password(Password)
    
    public enum Email {
        case isEmpty
    }
    
    public enum Password {
        case isEmpty
    }
}
