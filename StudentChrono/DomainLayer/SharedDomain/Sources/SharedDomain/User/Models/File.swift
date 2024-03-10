//
//  File.swift
//  
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Foundation

public struct File: Equatable, Codable {
    public let filename: String
    public let data: Data
    
    public init(
        filename: String,
        data: Data
    ) {
        self.filename = filename
        self.data = data
    }
}
