//
//  TaskState.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

public enum TaskState: String, Codable, Equatable, CaseIterable {
    case draft
    case todo
    case inProgress
    case review
    case done
}
