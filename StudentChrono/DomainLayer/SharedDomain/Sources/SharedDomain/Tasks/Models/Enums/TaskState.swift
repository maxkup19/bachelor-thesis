//
//  TaskState.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

public enum TaskState: String, Codable, Equatable, CaseIterable, Identifiable {
    
    public var id: String { rawValue }
    
    case draft
    case todo
    case inProgress
    case review
    case done
}
