import Fluent

struct CreateTeacher: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("tasks")
            .id()
            .field("name", .string, .required)
            .
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("students")
            .delete()
    }
}
