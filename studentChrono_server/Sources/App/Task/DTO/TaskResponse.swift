//
//  TaskResponse.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

struct TaskResponse: Content {
    var id: String
    var title: String
    var description: String
    var tags: [String]
    var comments: [MessageResponse]
    var state: TaskState
    var author: UserResponse
    var assignee: UserResponse?
    var dueTo: Date?
    var priority: Priority
    var createdAt: Date?
}

extension Task {
    func asTaskResponse(comments: [MessageResponse]) -> TaskResponse {
        TaskResponse(
            id: id?.uuidString ?? "",
            title: title,
            description: description,
            tags: tags,
            comments: comments,
            state: state,
            author: author.asUserResponse,
            assignee: assignee?.asUserResponse,
            dueTo: dueTo,
            priority: priority,
            createdAt: createdAt
        )
    }
}
