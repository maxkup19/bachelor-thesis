import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "Hello name"
    }
    
    try app.register(collection: TodoController())
}
