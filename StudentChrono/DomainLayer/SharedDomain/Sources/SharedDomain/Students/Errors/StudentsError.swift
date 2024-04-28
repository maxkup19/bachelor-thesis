//
//  StudentsError.swift
//
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Foundation

public enum StudentsError: Error, LocalizedError {
    case studentsError(description: String?)
    
    public var errorDescription: String? {
        switch self {
        case .studentsError(let description): description
        }
    }
}
