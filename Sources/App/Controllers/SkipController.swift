//
//  SkipController.swift
//  App
//
//  Created by Admin on 1/9/19.
//

import Vapor
import FluentSQLite
import Authentication

final class SkipController {
    
    func create(_ req: Request) throws -> Future<Response> {
        let user = try req.requireAuthenticated(User.self)
        return try req.content.decode(Skip.SkipForm.self).flatMap { skipForm in
            return User.find(skipForm.userId, on: req).flatMap { user in
                guard let userId = try user?.requireID() else {
                    throw Abort(.badRequest)
                }
                let skip = Skip(
                    text: skipForm.text,
                    userID: userId
                )
                return skip.save(on: req).map { _ in
                    return req.redirect(to: "/users")
                }
            }
        }
    }
    
    
    
}
