//
//  Message.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation
import Utilities

public struct Message: Codable, Equatable, Identifiable {
    public let id: String
    public let text: String
    public let author: User
    public let fileLink: String?
    public let createdAt: Date?
    
    public init(
        id: String,
        text: String,
        author: User,
        fileLink: String?,
        createdAt: Date?
    ) {
        self.id = id
        self.text = text
        self.author = author
        self.fileLink = fileLink
        self.createdAt = createdAt
    }
}
