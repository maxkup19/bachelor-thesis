//
//  NETChangeTaskStateData.swift
//  
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Foundation
import SharedDomain

struct NETChangeTaskStateData: Codable {
    let taskId: String
    let taskState: TaskState
}

extension ChangeTaskStateData {
    var networkModel: NETChangeTaskStateData {
        .init(
            taskId: taskId,
            taskState: taskState
        )
    }
}
