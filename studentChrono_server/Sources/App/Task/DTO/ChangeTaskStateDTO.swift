//
//  ChangeTaskStateDTO.swift
//
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Fluent
import Vapor

struct ChangeTaskStateDTO: Content {
    let taskId: String
    let taskState: TaskState
}
