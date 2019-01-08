//
//  UserController.swift
//  App
//
//  Created by Admin on 1/8/19.
//

import Vapor
import Crypto

final class UserController {
    
    func register(_ req: Request) throws -> Future<User.UserPublic> {
        return try req.content.decode(User.self).flatMap { user in
            let hasher = try req.make(BCryptDigest.self)
            let passwordHashed = try hasher.hash(user.password)
            let newUser = User(email: user.email, password: passwordHashed)
            
            return newUser.save(on: req).map { storedUser in
                return User.UserPublic(
                    id: try storedUser.requireID(),
                    email: storedUser.email
                )
            }
        }
    }
    
}

/*
 
 func list(_ req: Request) throws -> Future<View> {
 return User.query(on: req).all().flatMap { users in
 let data = ["userList": users]
 return try req.view().render("usersView", data)
 }
 }
 
 func create(_ req: Request) throws -> Future<Response> {
 return try req.content.decode(User.self).flatMap { user in
 return user.save(on: req).map { _ in
 return req.redirect(to: "users")
 }
 }
 }
 
 
 func listJSON(_ req: Request) throws -> Future<[User]> {
 return User.query(on: req).all()
 }
 
 func createJSON(_ req: Request) throws -> Future<User> {
 return try req.content.decode(User.self).flatMap { user in
 return user.save(on: req)
 }
 }
 
 func updateJSON(_ req: Request) throws -> Future<User> {
 return try req.parameters.next(User.self).flatMap { user in
 return try req.content.decode(User.self).flatMap { newUser in
 user.userName = newUser.userName
 user.age = newUser.age
 return user.save(on: req)
 }
 }
 }
 
 func deleteJSON(_ req: Request) throws -> Future<HTTPStatus> {
 return try req.parameters.next(User.self).flatMap { user in
 return user.delete(on: req)
 }.transform(to: .ok)
 }
 
 */
