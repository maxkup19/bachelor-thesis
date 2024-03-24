//
//  MessageMigration.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Fluent
import Vapor

extension Message {
    struct Migration: AsyncMigration {
        
        func prepare(on database: any Database) async throws {
            try await database.schema(schema)
                .id()
                .field(FieldKeys.authorId, .uuid, .references(SchemaEnum.users.rawValue, FieldKey.id), .required)
                .field(FieldKeys.text, .string, .required)
                .field(FieldKeys.file, .string)
                .field(FieldKeys.createdAt, .datetime)
                .create()
        }
        
        func revert(on database: any Database) async throws {
            try await database.schema(schema)
                .delete()
        }
        
    }
}
