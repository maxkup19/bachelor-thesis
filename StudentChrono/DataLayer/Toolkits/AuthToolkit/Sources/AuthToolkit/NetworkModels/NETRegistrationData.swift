//
//  NETRegistrationData.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

struct NETRegistrationData: Encodable {
    let email: String
    let pass: String
    let firstName: String
    let lastName: String
}

// Conversion from DomainModel to NetworkModel
extension RegistrationData {
    var networkModel: NETRegistrationData {
        NETRegistrationData(
            email: email,
            pass: password,
            firstName: firstName,
            lastName: lastName
        )
    }
}
