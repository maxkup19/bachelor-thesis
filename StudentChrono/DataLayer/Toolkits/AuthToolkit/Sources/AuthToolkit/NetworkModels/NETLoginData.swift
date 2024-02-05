//
//  NETLoginData.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import SharedDomain

struct NETLoginData: Encodable {
    let email: String
    let pass: String
}

// Conversion from DomainModel to NetworkModel
extension LoginData {
    var networkModel: NETLoginData {
        NETLoginData(
            email: email,
            pass: password
        )
    }
}
