//
//  StudentsRoutes.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Vapor

enum StudentsRoutes {
    static let base: PathComponent = "students"
    
    static let mine: PathComponent = "mine"
    static let nonMine: PathComponent = "nonMine"
}
