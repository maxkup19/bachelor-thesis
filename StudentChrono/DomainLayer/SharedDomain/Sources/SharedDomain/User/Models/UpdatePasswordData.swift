//
//  UpdatePasswordData.swift
//  
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import Foundation

public struct UpdatePasswordData: Equatable {
    public let password: String
    
    public init(password: String) {
        self.password = password
    }
}
