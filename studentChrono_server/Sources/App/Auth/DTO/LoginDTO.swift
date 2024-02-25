//
//  LoginDTO.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

struct LoginDTO: Content {
    var email: String
    var password: String
}
