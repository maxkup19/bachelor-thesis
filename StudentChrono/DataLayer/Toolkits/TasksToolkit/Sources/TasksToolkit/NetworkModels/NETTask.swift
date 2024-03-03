//
//  NETTask.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation
import SharedDomain
import UserToolkit

struct NETTask: Decodable {
    let id: String
    let title: String
    let description: String
    let tags: [String]
    let author: NETUser
    let assignee: NETUser?
    let state: TaskState
    let priority: Priority
    let createdAt: Date?
    let dueTo: Date?
}

extension NETTask {
    var domainModel: Task {
        Task(
            id: id,
            title: title,
            description: description,
            tags: tags,
            author: author.domainModel,
            assignee: assignee?.domainModel,
            state: state,
            priority: priority,
            createdAt: createdAt,
            dueTo: dueTo
        )
    }
}
