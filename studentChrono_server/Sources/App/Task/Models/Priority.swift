//
//  Priority.swift
//  
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Vapor

enum Priority: String, Content, Equatable, CaseIterable {
    case none
    case low
    case medium
    case high
}
