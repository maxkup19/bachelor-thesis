import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get { req in
        "IT WORKS"
    }
    
    try app.register(collection: UserController())
    try app.register(collection: AuthController())
    try app.register(collection: TaskController())
    try app.register(collection: StudentsController())
    try app.register(collection: FeedbackController())
}
