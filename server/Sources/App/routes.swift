import Fluent
import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<View> in
        return req.view.render("main")
    }
    
    app.post("info") { req -> String in
        let data = try req.content.decode(InfoData.self)
        return "Hello, \(data.name)!"
    }
    
    try app.register(collection: TodoController())
}
