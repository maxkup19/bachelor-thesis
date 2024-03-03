//
//  NETCreateTaskData.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Foundation
import SharedDomain

struct NETCreateTaskData: Codable {
    let title: String
    let description: String
    let tags: [String]
    let assigneeId: String?
    let dueTo: Date?
    let priority: Priority
}

extension CreateTaskData {
    var networkModel: NETCreateTaskData {
        NETCreateTaskData(
            title: title,
            description: description,
            tags: tags,
            assigneeId: assigneeId,
            dueTo: dueTo,
            priority: priority
        )
    }
}
