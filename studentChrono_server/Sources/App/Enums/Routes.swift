//
//  Routes.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//


enum UserRoutes: String {
    case users
    
    enum Options: String {
        case signup
        case login
        case me
    }
    
    enum Params: String {
        case id = ":id"
        case role = ":role"
    }
}

