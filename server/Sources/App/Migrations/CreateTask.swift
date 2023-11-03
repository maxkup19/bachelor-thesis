import Fluent

struct CreateTask: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("tasks")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("teacher_id", .uuid, .references("teachers", "id"), .required)
            .field("student_id", .uuid, .references("students", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("students")
            .delete()
    }
}
