//
//  TaskState.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

enum TaskState: String, Content, Equatable, CaseIterable {
    case draft
    case todo
    case inProgress
    case review
    case done
}
