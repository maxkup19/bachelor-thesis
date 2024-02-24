//
//  TokenMigration.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Fluent
import Vapor

extension Token {
    struct Migration: AsyncMigration {
        
        func prepare(on database: Database) async throws {
            try await database.schema(schema)
                .id()
                .field(FieldKeys.userId, .uuid, .references(SchemaEnum.users.rawValue, FieldKey.id))
                .field(FieldKeys.value, .string, .required)
                .field(FieldKeys.source, .string, .required)
                .field(FieldKeys.expiresAt, .datetime, .required)
                .field(FieldKeys.createdAt, .datetime)
                .unique(on: FieldKeys.value)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(schema)
                .delete()
        }
    }
}
