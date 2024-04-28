//
//  ChangeTaskStateData.swift
//  
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Foundation

public struct ChangeTaskStateData: Codable {
    public let taskId: String
    public let taskState: TaskState
    
    public init(
        taskId: String,
        taskState: TaskState
    ) {
        self.taskId = taskId
        self.taskState = taskState
    }
}
