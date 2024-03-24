//
//  Task+Stubs.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SharedDomain

public extension Task {
    static let task1Stub = Task(
        id: "task1",
        title: "Task 1",
        description: "",
        tags: [],
        comments: [],
        author: User.teacherStub,
        assignee: nil,
        state: .draft,
        priority: .none,
        createdAt: nil,
        dueTo: nil
    )
    
    static let task2Stub = Task(
        id: "task2",
        title: "Task 2",
        description: "Some description",
        tags: [],
        comments: [],
        author: User.teacherStub,
        assignee: User.studentStub,
        state: .inProgress,
        priority: .medium,
        createdAt: .now,
        dueTo: nil
    )
}
