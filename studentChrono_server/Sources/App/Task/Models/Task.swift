//
//  Task.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Foundation
import Fluent
import Vapor

final class Task: Model {
    
    static let schema: String = SchemaEnum.tasks.rawValue
    
    @ID
    var id: UUID?
    
    @Field(key: FieldKeys.title)
    var title: String
    
    @Field(key: FieldKeys.description)
    var description: String
    
    @Field(key: FieldKeys.tags)
    var tags: [String]
    
    @Field(key: FieldKeys.comments)
    var comments: [UUID]
    
    @Enum(key: FieldKeys.state)
    var state: TaskState
    
    @Parent(key: FieldKeys.authorId)
    var author: User
    
    @OptionalParent(key: FieldKeys.assigneeId)
    var assignee: User?
    
    @OptionalField(key: FieldKeys.dueTo)
    var dueTo: Date?
    
    @Enum(key: FieldKeys.priority)
    var priority: Priority
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        title: String,
        description: String,
        tags: [String],
        state: TaskState,
        authorId: User.IDValue,
        assigneeId: User.IDValue?,
        dueTo: Date?,
        priority: Priority
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.tags = tags
        self.comments = []
        self.state = state
        self.$author.id = authorId
        self.$assignee.id = assigneeId
        self.dueTo = dueTo
        self.priority = priority
    }
    
    // MARK: - Update task init
    
    init(
        title: String,
        description: String,
        state: TaskState
    ) {
        self.title = title
        self.description = description
        self.state = state
    }
}
