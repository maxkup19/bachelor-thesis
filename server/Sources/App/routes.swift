import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

//    app.get("hello") { req async -> String in
//        "Hello, world!"
//    }
    
    app.get("hello", ":name") { req -> String in
      guard let name = req.parameters.get("name") else {
          throw Abort(.badRequest)
      }
      return "Hello, \(name)!"
    }

    app.post("info") { req -> String in
        let data = try req.content.decode(InfoData.self)
        return "Hello, \(data.name)!"
    }

    try app.register(collection: TodoController())
}
