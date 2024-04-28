//
//  FeedbackError.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import Foundation

public enum FeedbackError: Error, LocalizedError {
    case feedbackError(description: String?)
    
    public var errorDescription: String? {
        switch self {
        case .feedbackError(let description): description
        }
    }
}
