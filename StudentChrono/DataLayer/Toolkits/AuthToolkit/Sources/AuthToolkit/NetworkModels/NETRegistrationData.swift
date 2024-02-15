//
//  NETRegistrationData.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

struct NETRegistrationData: Encodable {
    let email: String
    let password: String
    let name: String
    let lastName: String
}

// Conversion from DomainModel to NetworkModel
extension RegistrationData {
    var networkModel: NETRegistrationData {
        NETRegistrationData(
            email: email,
            password: password,
            name: name,
            lastName: lastName
        )
    }
}
