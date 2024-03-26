//
//  NETUpdateTaskData.swift
//  
//
//  Created by Maksym Kupchenko on 27.03.2024.
//

import Foundation
import SharedDomain

struct NETUpdateTaskData: Codable {
    let taskId: String
    let title: String
    let description: String
    let tags: [String]
    let assigneeId: String?
    let dueTo: Date?
    let priority: Priority
}

extension UpdateTaskData {
    var networkModel: NETUpdateTaskData {
        NETUpdateTaskData(
            taskId: taskId,
            title: title,
            description: description,
            tags: tags,
            assigneeId: assigneeId,
            dueTo: dueTo,
            priority: priority
        )
    }
}
