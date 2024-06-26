import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    if let urlString = Environment.get("DATABASE_URL") {
        var postgersConfig = try SQLPostgresConfiguration(url: urlString)
        var tlsConfig = TLSConfiguration.makeClientConfiguration()
        tlsConfig.certificateVerification = .none
        postgersConfig.coreConfiguration.tls = .prefer(try .init(configuration: tlsConfig))
        app.databases.use(.postgres(configuration: postgersConfig), as: .psql)
    } else {
        app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? "vapor_database",
            tls: .prefer(try .init(configuration: .clientDefault)))
        ), as: .psql)
    }
    
    
    // MARK: - Setup Migrations
    app.migrations.add(User.Migration())
    app.migrations.add(Token.Migration())
    app.migrations.add(Task.Migration())
    app.migrations.add(Feedback.Migration())
    app.migrations.add(Message.Migration())
    
    if app.environment == .development {
        try await app.autoMigrate()
    }
    
    // MARK: - Setup Middleware
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.routes.defaultMaxBodySize = "10mb"
    
    // MARK: - Register routes
    try routes(app)
}
