//
//  Priority.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

public enum Priority: String, Codable, Equatable, CaseIterable, Identifiable {
    
    public var id: String { rawValue }
    
    case none
    case low
    case medium
    case high
}
