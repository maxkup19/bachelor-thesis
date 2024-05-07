//
//  NETAddMessageToTaskData.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation
import SharedDomain
import UserToolkit

struct NETAddMessageToTaskData: Codable {
    let taskId: String
    let text: String
    let file: String?
}

extension AddMessageToTaskData {
    func networkModel(file: String?) -> NETAddMessageToTaskData {
        NETAddMessageToTaskData(
            taskId: taskId,
            text: text,
            file: file
        )
    }
}
