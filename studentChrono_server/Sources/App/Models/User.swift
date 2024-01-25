//
//  User.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent
import Vapor

final class User: Model {
    
    static let schema: String = SchemaEnum.users.rawValue
    
    @ID
    var id: UUID?
    
    @OptionalField(key: FieldKeys.name)
    var name: String?
    
    @OptionalField(key: FieldKeys.lastname)
    var lastname: String?
    
    @Field(key: FieldKeys.email)
    var email: String
    
    @Field(key: FieldKeys.password)
    var password: String
    
    @Field(key: FieldKeys.role)
    var role: UserRoleEnum.RawValue
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        name: String?,
        lastname: String?,
        email: String,
        password: String,
        role: UserRoleEnum.RawValue
    ) {
        self.name = name
        self.lastname = lastname
        self.email = email
        self.password = password
        self.role = role
    }
    
    init(role: UserRoleEnum.RawValue) {
        self.role = role
    }
    
}

extension User: Content { }
