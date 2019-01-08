//
//  User.swift
//  App
//
//  Created by Admin on 1/8/19.
//

import FluentSQLite
import Vapor
import Authentication

final class User: SQLiteModel {
    var id: Int?
    var userName: String
    var age: Int
    init(id: Int? = nil, userName: String, age: Int) {
        self.id = id
        self.userName = userName
        self.age = age
    }
    
}

extension User: TokenAuthenticatable {
    typealias TokenType = Token
}

extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
