//
//  Task.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Fluent
import Vapor

final class Task: Model {
    
    static let schema: String = SchemaEnum.tasks.rawValue
    
    @ID
    var id: UUID?
    
    @Field(key: FieldKeys.title)
    var title: String
    
    @Field(key: FieldKeys.description)
    var description: String?
    
    @Enum(key: FieldKeys.state)
    var state: TaskState
    
    @Parent(key: FieldKeys.authorId)
    var author: User
    
    @OptionalParent(key: FieldKeys.assigneeId)
    var assignee: User?
    
    @OptionalField(key: FieldKeys.dueTo)
    var dueTo: Date?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        title: String,
        description: String,
        state: TaskState = .draft,
        authorId: User.IDValue,
        assigneeId: User.IDValue?,
        dueTo: Date?
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.state = state
        self.$author.id = authorId
        self.$assignee.id = assigneeId
        self.dueTo = dueTo
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
