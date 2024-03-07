//
//  File.swift
//  
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Foundation

public struct File: Equatable, Codable {
    public let name: String
    public let data: Data
    
    public init(
        name: String,
        data: Data
    ) {
        self.name = name
        self.data = data
    }
}
