//
//  TaskResponse.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

struct TaskResponse: Content {
    var title: String
    var description: String?
    var state: TaskState
    var author: UserResponse
    var assignee: UserResponse?
    var dueTo: Date?
    var createdAt: Date?
}

extension Task {
    var asTaskResponse: TaskResponse {
        TaskResponse(
            title: title,
            description: description,
            state: state,
            author: author.asUserResponse,
            assignee: assignee?.asUserResponse,
            dueTo: dueTo,
            createdAt: createdAt
        )
    }
}
