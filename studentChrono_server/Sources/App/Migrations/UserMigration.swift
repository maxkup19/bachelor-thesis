//
//  UserMigration.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent
import Vapor

extension User {
    struct Migration: AsyncMigration {
        
        private let schema = User.schema
        private let keys = User.FieldKeys.self
        
        func prepare(on database: Database) async throws {
            try await database.schema(schema)
                .id()
                .field(keys.name, .string)
                .field(keys.lastname, .string)
                .field(keys.email, .string, .required)
                .field(keys.password, .string, .required)
                .field(keys.role, .string, .required)
                .field(keys.createdAt, .datetime)
                .field(keys.updatedAt, .datetime)
                .unique(on: keys.email)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(schema)
                .delete()
        }
    }
}
