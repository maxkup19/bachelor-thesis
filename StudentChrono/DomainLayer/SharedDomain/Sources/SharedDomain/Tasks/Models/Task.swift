//
//  Task.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

public struct Task: Equatable, Codable, Identifiable {
    public let id: String
    public let title: String
    public let description: String
    public let tags: [String]
    public let comments: [Message]
    public let author: User
    public let assignee: User?
    public let state: TaskState
    public let priority: Priority
    public let createdAt: Date?
    public let dueTo: Date?
    
    public init(
        id: String,
        title: String,
        description: String,
        tags: [String],
        comments: [Message],
        author: User,
        assignee: User?,
        state: TaskState,
        priority: Priority,
        createdAt: Date?,
        dueTo: Date?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.tags = tags
        self.comments = comments
        self.author = author
        self.assignee = assignee
        self.state = state
        self.priority = priority
        self.createdAt = createdAt
        self.dueTo = dueTo
    }
}
