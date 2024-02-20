//
//  NETUser.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SharedDomain

struct NETUser: Decodable {
    let name: String
    let lastname: String
    let email: String
    let role: UserRoleEnum
}

// Conversion from NetworkModel to DomainModel
extension NETUser {
    var domainModel: User {
        User(
            name: name,
            lastname: lastname,
            email: email,
            role: role
        )
    }
}
