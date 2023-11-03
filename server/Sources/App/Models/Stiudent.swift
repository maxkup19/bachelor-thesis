import Vapor
import Fluent

final class Student: Model {
    static let schema = "students"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    
    
    init() { }
    
    init(
        id: UUID? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
