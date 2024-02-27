//
//  TaskResponse.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

struct TaskResponse: Content {
    var title: String
    var description: String
    var tags: [String]
    var state: TaskState
    var author: UserResponse
    var assignee: UserResponse?
    var dueTo: Date?
    var priority: Priority
    var createdAt: Date?
}

extension Task {
    var asTaskResponse: TaskResponse {
        TaskResponse(
            title: title,
            description: description,
            tags: tags,
            state: state,
            author: author.asUserResponse,
            assignee: assignee?.asUserResponse,
            dueTo: dueTo,
            priority: priority,
            createdAt: createdAt
        )
    }
}
