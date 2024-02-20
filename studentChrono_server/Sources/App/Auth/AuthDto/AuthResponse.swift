//
//  AuthResponse.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

struct AuthResponse: Content {
    var userId: String
    var token: String
}
