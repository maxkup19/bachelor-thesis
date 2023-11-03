import Fluent
import Vapor

final class Task: Model {
    static let schema = "tasks"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Parent(key: "teacher_id")
    var teacher: Teacher // Teacher who created the task
    
    @Parent(key: "student_id", optional: true)
    var student: Student? // Student assigned the task
    
    init() { }
    
    init(
        id: UUID? = nil,
        title: String,
        description: String,
        teacher: Teacher,
        student: Student? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.teacher = teacher
        self.student = student
    }
    
}
