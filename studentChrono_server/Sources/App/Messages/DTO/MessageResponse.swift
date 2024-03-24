//
//  MessageResponse.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation
import Fluent
import Vapor

struct MessageResponse: Content {
    var id: String
    var author: UserResponse
    var text: String
    var fileLink: String?
    var createdAt: Date?
}

extension Message {
    var asResponse: MessageResponse {
        MessageResponse(
            id: id?.uuidString ?? "",
            author: author.asUserResponse,
            text: text,
            fileLink: file,
            createdAt: createdAt
        )
    }
}
