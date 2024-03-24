//
//  NETMessage.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Foundation
import SharedDomain
import UserToolkit

struct NETMessage: Decodable {
    let id: String
    let text: String
    let author: NETUser
    let fileLink: String?
    let createdAt: Date?
}

extension NETMessage {
    var domainModel: Message {
        Message(
            id: id,
            text: text,
            author: author.domainModel,
            fileLink: fileLink,
            createdAt: createdAt
        )
    }
}
