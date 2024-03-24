//
//  Message+Stubs.swift
//  
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import SharedDomain

public extension Message {
    static let stub = Message(
        id: "1",
        text: "This is comment by teacher",
        author: User.teacherStub,
        fileLink: nil,
        createdAt: nil
    )
}
