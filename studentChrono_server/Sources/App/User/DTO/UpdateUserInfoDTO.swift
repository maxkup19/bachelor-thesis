//
//  UpdateUserInfoDTO.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import Vapor

struct UpdateUserInfoDTO: Content {
    var name: String?
    var lastName: String?
    var birthDay: Date?
}
