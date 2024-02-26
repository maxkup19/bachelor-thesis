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
    let assigneeId: UUID?
    let dueTo: Date?
}

extension CreateTaskData {
    var networkModel: NETCreateTaskData {
        NETCreateTaskData(
            title: title,
            description: description,
            assigneeId: assigneeId,
            dueTo: dueTo
        )
    }
}
