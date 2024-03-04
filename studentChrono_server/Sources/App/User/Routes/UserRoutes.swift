//
//  UserRoutes.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Vapor

enum UserRoutes {
    static let base: PathComponent = "user"
    
    static let me: PathComponent = "me"
    static let deleteAccount: PathComponent = "deleteAccount"
    static let image: PathComponent = "image"
    static let info: PathComponent = "info"
}

