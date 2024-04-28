//
//  UserError.swift
//
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Foundation

public enum UserError: Error, LocalizedError {
    case userError(description: String?)
    
    public var errorDescription: String? {
        switch self {
        case .userError(let description): description
        }
    }
}
