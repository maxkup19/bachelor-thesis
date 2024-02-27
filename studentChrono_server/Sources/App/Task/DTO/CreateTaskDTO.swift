//
//  CreateTaskDTO.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

struct CreateTaskDTO: Content {
    var title: String
    var description: String
    var tags: [String]?
    var state: TaskState?
    var assigneeId: UUID?
    var dueTo: Date?
    var priority: Priority
}

extension CreateTaskDTO {
    func asTask(authorId: UUID) -> Task {
        Task(
            title: title,
            description: description,
            tags: tags ?? [],
            state: state ?? .todo,
            authorId: authorId,
            assigneeId: assigneeId,
            dueTo: dueTo,
            priority: priority
        )
    }
}
