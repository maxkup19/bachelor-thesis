//
//  Token.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent

final class Token: Model {
    
    static let schema: String = SchemaEnum.tokens.rawValue
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: FieldKeys.userId)
    var user: User
    
    @Field(key: FieldKeys.value)
    var value: String
    
    @Field(key: FieldKeys.source)
    var source: SessionSourceEnum.RawValue
    
    @Field(key: FieldKeys.expiresAt)
    var expiresAt: Date?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        userId: User.IDValue,
        token: String,
        source: SessionSourceEnum.RawValue,
        expiresAt: Date?
    ) {
        self.id = id
        self.$user.id = userId
        self.value = token
        self.source = source
        self.expiresAt = expiresAt
    }
}

extension Token: ModelTokenAuthenticatable {
  static let valueKey = \Token.$value
  static let userKey = \Token.$user
  
  var isValid: Bool {
    guard let expiryDate = expiresAt else {
      return true
    }
    
    return expiryDate > Date()
  }
}
