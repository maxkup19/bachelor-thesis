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
    public let assigneeId: UUID?
    public let dueTo: Date?
    
    public init(
        title: String,
        description: String,
        assigneeId: UUID?,
        dueTo: Date?
    ) {
        self.title = title
        self.description = description
        self.assigneeId = assigneeId
        self.dueTo = dueTo
    }
}
