//
//  UserRoleEnum.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

public enum UserRoleEnum: String, Codable, Equatable, CaseIterable, Identifiable {
    
    public var id: String { rawValue }
    
    case admin
    case teacher
    case student
}
