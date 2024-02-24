//
//  NETUser.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import SharedDomain

struct NETUser: Decodable {
    let name: String
    let lastName: String
    let email: String
    let birthDay: Date
    let role: UserRoleEnum
}

// Conversion from NetworkModel to DomainModel
extension NETUser {
    var domainModel: User {
        User(
            name: name,
            lastName: lastName,
            email: email,
            role: role,
            birthDay: birthDay
        )
    }
}
