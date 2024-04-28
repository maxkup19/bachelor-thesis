//
//  TasksError.swift
//  
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Foundation

public enum TasksError: Error, LocalizedError {
    case tasksError(description: String?)
    
    public var errorDescription: String? {
        switch self {
        case .tasksError(let description): description
        }
    }
}
