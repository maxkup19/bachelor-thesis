//
//  NETUpdatePasswordData.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import SharedDomain

struct NETUpdatePasswordData: Codable {
    let password: String
}

extension UpdatePasswordData {
    var networkModel: NETUpdatePasswordData {
        NETUpdatePasswordData(password: password)
    }
}
