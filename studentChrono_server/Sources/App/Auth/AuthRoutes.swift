//
//  AuthRoutes.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor
    
enum AuthRoutes {
    static let base: PathComponent = "auth"
    
    static let login: PathComponent = "login"
    static let signup: PathComponent = "signup"
}
