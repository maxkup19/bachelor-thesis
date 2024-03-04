//
//  NETUpdateUserInfoData.swift
//  
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import Foundation
import SharedDomain

struct NETUpdateUserInfoData: Codable {
    let name: String?
    let lastName: String?
    let birthDay: Date?
}

extension UpdateUserInfoData {
    var networkModel: NETUpdateUserInfoData {
        NETUpdateUserInfoData(
            name: name,
            lastName: lastName,
            birthDay: birthDay
        )
    }
}
