//
//  NETUser.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import SharedDomain

public struct NETUser: Decodable {
    let id: String
    let name: String
    let lastName: String
    let email: String
    let birthDay: Date
    let role: UserRoleEnum
    let imageURL: String?
}

// Conversion from NetworkModel to DomainModel
public extension NETUser {
    var domainModel: User {
        User(
            id: id,
            name: name,
            lastName: lastName,
            email: email,
            role: role,
            birthDay: birthDay
        )
    }
}
