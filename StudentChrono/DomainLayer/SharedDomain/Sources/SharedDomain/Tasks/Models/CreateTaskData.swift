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
    public let authorId: UUID
    public let assigneeId: UUID?
    public let dueTo: Date?
    
    public init(
        title: String,
        description: String,
        authorId: UUID,
        assigneeId: UUID?,
        dueTo: Date?
    ) {
        self.title = title
        self.description = description
        self.authorId = authorId
        self.assigneeId = assigneeId
        self.dueTo = dueTo
    }
}
