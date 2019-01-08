import FluentSQLite
import Vapor
import Leaf

/// Called before your application initializes.
public func configure(_ config: inout Config,
                      _ env: inout Environment,
                      _ services: inout Services)
    throws {

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
        
        
    let leafProvider = LeafProvider()    // added
    try services.register(leafProvider)  // added
    
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
        
    try services.register(FluentSQLiteProvider())
    var databases = DatabasesConfig()
        try databases.add(database: SQLiteDatabase(storage: .memory), as: .sqlite)
        //.file(path: "skipiter_web_db")  - permanent will create a db file on disk
        //.memory ~ temporary will be destroyed on re-run
    services.register(databases)
        
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .sqlite)
    services.register(migrations)
        
    ///CHANGE LISTENING PORT TO 8001
//    let myService = NIOServerConfig.default(port: 8001)
//    services.register(myService)



}

/* ORIGINAL TEMPLATE
 
     /// Register providers first
     try services.register(FluentSQLiteProvider())
 
     /// Register routes to the router
     let router = EngineRouter.default()
     try routes(router)
     services.register(router, as: Router.self)
 
     /// Register middleware
     var middlewares = MiddlewareConfig() // Create _empty_ middleware config
     /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
     middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
     services.register(middlewares)
 
     // Configure a SQLite database
     let sqlite = try SQLiteDatabase(storage: .memory)
 
     /// Register the configured SQLite database to the database config.
     var databases = DatabasesConfig()
     databases.add(database: sqlite, as: .sqlite)
     services.register(databases)
 
     /// Configure migrations
     var migrations = MigrationConfig()
     migrations.add(model: Todo.self, database: .sqlite)
     services.register(migrations)
 
 */
