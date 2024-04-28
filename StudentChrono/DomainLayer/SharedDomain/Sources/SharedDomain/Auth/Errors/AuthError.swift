//
//  AuthError.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public enum AuthError: Error, LocalizedError {
    case authError(description: String?)
    
    public var errorDescription: String? {
        switch self {
        case .authError(let description): description
        }
    }
}
