//
//  UserRoleEnum.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

enum UserRoleEnum: String, Content, Equatable, CaseIterable {
    case admin
    case student
    case teacher
}
