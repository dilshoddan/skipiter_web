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
    
    func create(_ req: Request) throws -> Future<Skip.SkipForm> {
        let user = try req.requireAuthenticated(User.self)
        
        return try req.content.decode(Skip.SkipForm.self).flatMap { skipForm in
            return User.find(skipForm.userId, on: req).flatMap { user in
                guard let userId = try user?.requireID() else {
                    throw Abort(.badRequest)
                }
                let newSkip = Skip(
                    text: skipForm.text,
                    userID: userId
                )
                return newSkip.save(on: req).map { s in
                    return Skip.SkipForm(text: s.text, userId: userId)
                }
            }
        }
    }
    
    
    
}
