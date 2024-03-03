//
//  User.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Foundation
import Fluent
import Vapor

final class User: Model {
    
    static let schema: String = SchemaEnum.users.rawValue
    
    @ID
    var id: UUID?
    
    @Field(key: FieldKeys.name)
    var name: String
    
    @Field(key: FieldKeys.lastName)
    var lastName: String
    
    @Field(key: FieldKeys.email)
    var email: String
    
    @Field(key: FieldKeys.password)
    var password: String
    
    @Field(key: FieldKeys.role)
    var role: UserRoleEnum
    
    @Field(key: FieldKeys.birthDay)
    var birthDay: Date
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        name: String,
        lastName: String,
        email: String,
        password: String,
        birthDay: Date,
        role: UserRoleEnum
    ) {
        self.name = name
        self.lastName = lastName
        self.email = email
        self.password = password
        self.birthDay = birthDay
        self.role = role
    }
    
    init(
        email: String,
        password: String
    ) {
        self.email = email
        self.password = password
    }
    
    init(role: UserRoleEnum) {
        self.role = role
    }
    
    func createToken(source: SessionSourceEnum) throws -> Token {
        let calendar = Calendar(identifier: .gregorian)
        let expiryDate = calendar.date(byAdding: Configuration.tokenExpiryDate, to: .now)
        return try Token(
            userId: requireID(),
            token: [UInt8].random(count: 16).base64,
            source: source.rawValue,
            expiresAt: expiryDate
        )
    }
}

extension User: Content { }

extension User: Authenticatable, ModelAuthenticatable {
  static let usernameKey = \User.$email
  static let passwordHashKey = \User.$password
  
  func verify(password: String) throws -> Bool {
    try Bcrypt.verify(password, created: self.password)
  }
}
