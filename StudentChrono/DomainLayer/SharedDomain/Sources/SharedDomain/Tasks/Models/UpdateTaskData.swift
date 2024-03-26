//
//  UpdateTaskData.swift
//  
//
//  Created by Maksym Kupchenko on 27.03.2024.
//

import Foundation

public struct UpdateTaskData: Equatable {
    public let taskId: String
    public let title: String
    public let description: String
    public let tags: [String]
    public let assigneeId: String?
    public let dueTo: Date?
    public let priority: Priority
    
    public init(
        taskId: String,
        title: String,
        description: String,
        tags: [String],
        assigneeId: String?,
        dueTo: Date?,
        priority: Priority
    ) {
        self.taskId = taskId
        self.title = title
        self.description = description
        self.tags = tags
        self.assigneeId = assigneeId
        self.dueTo = dueTo
        self.priority = priority
    }
}
