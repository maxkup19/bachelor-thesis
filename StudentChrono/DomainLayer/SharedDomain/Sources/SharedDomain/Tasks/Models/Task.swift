//
//  Task.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

public struct Task: Equatable, Codable {
    public let title: String
    public let description: String
    public let tags: [String]
    public let author: User
    public let assignee: User?
    public let state: TaskState
    public let priority: Priority
    public let createdAt: Date?
    public let dueTo: Date?
    
    public init(
        title: String,
        description: String,
        tags: [String],
        author: User,
        assignee: User?,
        state: TaskState,
        priority: Priority,
        createdAt: Date?,
        dueTo: Date?
    ) {
        self.title = title
        self.description = description
        self.tags = tags
        self.author = author
        self.assignee = assignee
        self.state = state
        self.priority = priority
        self.createdAt = createdAt
        self.dueTo = dueTo
    }
}
