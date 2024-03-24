//
//  Message.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation
import Fluent
import Vapor

final class Message: Model {
    
    static let schema: String = SchemaEnum.messages.rawValue
    
    @ID
    var id: UUID?
    
    @Parent(key: FieldKeys.authorId)
    var author: User
    
    @Field(key: FieldKeys.text)
    var text: String
    
    @Field(key: FieldKeys.file)
    var file: String?
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    init() { }
    
    init(
        authorId: User.IDValue,
        text: String,
        file: String? = nil
    ) {
        self.$author.id = authorId
        self.text = text
        self.file = file
    }
    
}
