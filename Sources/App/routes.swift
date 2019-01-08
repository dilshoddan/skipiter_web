import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get("name") { req in
        return "Dilshod Abdullaev"
    }
    
    router.get("age") { req in
        return 32
    }
    
    router.get("json") { req in
        return Person(name: "Dilshod", age: 32)
    }
}




struct Person: Content {
    var name: String
    var age: Int
}

/* ORIGINAL TEMPLATE
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }

    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
 
 */
