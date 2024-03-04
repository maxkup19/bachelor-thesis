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
        
        func prepare(on database: Database) async throws {
            try await database.schema(schema)
                .id()
                .field(FieldKeys.name, .string)
                .field(FieldKeys.lastName, .string)
                .field(FieldKeys.email, .string, .required)
                .field(FieldKeys.password, .string, .required)
                .field(FieldKeys.role, .string, .required)
                .field(FieldKeys.studentIds, .array(of: .uuid), .required)
                .field(FieldKeys.birthDay, .date, .required)
                .field(FieldKeys.image, .string)
                .field(FieldKeys.createdAt, .datetime)
                .field(FieldKeys.updatedAt, .datetime)
                .unique(on: FieldKeys.email)
                .create()
        }
        
        func revert(on database: Database) async throws {
            try await database.schema(schema)
                .delete()
        }
    }
}
