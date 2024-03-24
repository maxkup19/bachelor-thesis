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
    var text: String
    var fileLink: String?
    var createdAt: Date?
}

extension Message {
    var asResponse: MessageResponse {
        MessageResponse(
            text: text,
            fileLink: file,
            createdAt: createdAt
        )
    }
}
