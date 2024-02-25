//
//  TaskMigration.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Fluent
import Vapor

extension Task {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(schema)
                .id()
                .field(FieldKeys.title, .string, .required)
                .field(FieldKeys.description, .string)
                .field(FieldKeys.state, .string, .required)
                .field(FieldKeys.authorId, .uuid, .references(SchemaEnum.users.rawValue, FieldKey.id), .required)
                .field(FieldKeys.assigneeId, .uuid, .references(SchemaEnum.users.rawValue, FieldKey.id))
                .field(FieldKeys.dueTo, .datetime)
                .field(FieldKeys.createdAt, .datetime)
                .field(FieldKeys.updatedAt, .datetime)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(schema)
                .delete()
        }
    }
}
