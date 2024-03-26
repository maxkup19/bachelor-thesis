//
//  UpdateTaskDTO.swift
//  
//
//  Created by Maksym Kupchenko on 26.03.2024.
//

import Vapor

struct UpdateTaskDTO: Content {
    var taskId: String
    var title: String?
    var description: String?
    var tags: [String]?
    var assigneeId: String
    var dueTo: Date?
    var priority: Priority?
}
