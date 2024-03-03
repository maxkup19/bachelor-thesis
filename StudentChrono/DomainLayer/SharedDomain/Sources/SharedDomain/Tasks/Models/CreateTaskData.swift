//
//  CreateTaskData.swift
//  
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Foundation

public struct CreateTaskData: Equatable {
    public let title: String
    public let description: String
    public let tags: [String]
    public let assigneeId: String?
    public let dueTo: Date?
    public let priority: Priority
    
    public init(
        title: String,
        description: String,
        tags: [String],
        assigneeId: String?,
        dueTo: Date?,
        priority: Priority
    ) {
        self.title = title
        self.description = description
        self.tags = tags
        self.assigneeId = assigneeId
        self.dueTo = dueTo
        self.priority = priority
    }
}
