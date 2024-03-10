//
//  FeedbackMigration.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Fluent
import Vapor

extension Feedback {
    struct Migration: AsyncMigration {
        
        func prepare(on database: any Database) async throws {
            try await database.schema(schema)
                .id()
                .field(FieldKeys.email, .string, .required)
                .field(FieldKeys.description, .string, .required)
                .field(FieldKeys.screenshotName, .string)
                .field(FieldKeys.status, .string, .required)
                .field(FieldKeys.createdAt, .datetime)
                .field(FieldKeys.updatedAt, .datetime)
                .create()
        }
        
        func revert(on database: any Database) async throws {
            try await database.schema(schema)
                .delete()
        }
    }
}
