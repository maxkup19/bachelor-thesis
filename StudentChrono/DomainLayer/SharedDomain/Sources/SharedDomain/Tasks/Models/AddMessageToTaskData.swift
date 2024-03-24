//
//  AddMessageToTaskData.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation

public struct AddMessageToTaskData: Codable {
    public let taskId: String
    public let text: String
    public let file: File?
    
    public init(
        taskId: String,
        text: String,
        file: File?
    ) {
        self.taskId = taskId
        self.text = text
        self.file = file
    }
}
