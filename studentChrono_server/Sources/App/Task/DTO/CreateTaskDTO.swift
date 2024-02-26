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
    var assigneeId: UUID?
    var dueTo: Date?
}

extension CreateTaskDTO {
    func asTask(authorId: UUID) -> Task {
        Task(
            title: title,
            description: description,
            authorId: authorId,
            assigneeId: assigneeId,
            dueTo: dueTo
        )
    }
}
