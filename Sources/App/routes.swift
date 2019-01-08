import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get("json") { req in
        return Person(name: "Dilshod", age: 32)
    }
    
    router.get("view") { req -> Future<View> in
        return try req.view().render("welcome")
    }
    
    router.get("RawData") { req -> Future<View> in
        let data = ["name": "Dilshod", "age": "32"]
        return try req.view().render("whoAmI", data)
    }
    
    router.get("person") { req -> Future<View> in
        let person = Person(name: "Dilshod", age: 32)
        return try req.view().render("whoAmI", person)
    }
    
//    router.get("users") { req -> Future<View> in
//        return User.query(on: req).all().flatMap { users in
//            let data = ["userList": users]
//            return try req.view().render("usersView", data)
//        }
//
//    }
    let userController = UserController()
    router.get("users", use: userController.list)
    
//    router.post("users") { req -> Future<Response> in
//        return try req.content.decode(User.self).flatMap { user in
//            return user.save(on: req).map { _ in
//                return req.redirect(to: "users")
//            }
//        }
//    }
    router.post("users", use: userController.create)
    
    router.get("usersJSON", use: userController.listJSON)
    //call the post route on terminal like below or use postman or paw
    //curl -H "Content-Type: application/json" -X POST -d '{"userName": "Fiona", "age": 23}' http://localhost:8080/usersJSON
    router.post("usersJSON", use: userController.createJSON)
    
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
