import Vapor
import Fluent

final class Teacher: Model {
    static let schema = "teachers"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Children(for: \.$teacher)
    var tasks: [Task] // Tasks created by the teacher
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
