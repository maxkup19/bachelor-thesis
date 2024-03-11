//
//  Feedback.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Foundation
import Fluent
import Vapor

final class Feedback: Model {
    
    static let schema: String = SchemaEnum.feedback.rawValue
    
    @ID
    var id: UUID?
    
    @Field(key: FieldKeys.email)
    var email: String
    
    @Field(key: FieldKeys.description)
    var description: String
    
    @Field(key: FieldKeys.screenshotName)
    var screenshotName: String?
    
    @Field(key: FieldKeys.status)
    var status: FeedbackStatus
    
    @Timestamp(key: FieldKeys.createdAt, on: .create)
    var createdAt: Date?
    
    @Timestamp(key: FieldKeys.updatedAt, on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(
        email: String,
        description: String,
        screenshotName: String?,
        status: FeedbackStatus = .created
    ) {
        self.email = email
        self.description = description
        self.screenshotName = screenshotName
        self.status = status
    }
}
