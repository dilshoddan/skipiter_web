//
//  UserController.swift
//  App
//
//  Created by Admin on 1/8/19.
//

import Vapor

final class UserController {
    
    func list(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap { users in
            let data = ["userList": users]
            return try req.view().render("usersView", data)
        }
    }
    
    func listJSON(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(User.self).flatMap { user in
            return user.save(on: req).map { _ in
                return req.redirect(to: "users")
            }
        }
    }
}
