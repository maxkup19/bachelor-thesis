//
//  UpdateUserInfoData.swift
//  
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import Foundation

public struct UpdateUserInfoData: Equatable {
    public let name: String?
    public let lastName: String?
    public let birthDay: Date?
    
    public init(
        name: String?,
        lastName: String?,
        birthDay: Date?
    ) {
        self.name = name
        self.lastName = lastName
        self.birthDay = birthDay
    }
}
