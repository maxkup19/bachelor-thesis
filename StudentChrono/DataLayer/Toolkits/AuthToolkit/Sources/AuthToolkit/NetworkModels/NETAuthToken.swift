//
//  NETAuthToken.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

struct NETAuthToken: Decodable {
    let userId: String
    let token: String
}

// Conversion from NetworkModel to DomainModel
extension NETAuthToken {
    var domainModel: AuthToken {
        AuthToken(
            userId: userId,
            token: token
        )
    }
}
