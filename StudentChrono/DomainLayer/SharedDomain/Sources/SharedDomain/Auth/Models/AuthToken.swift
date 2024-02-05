//
//  AuthToken.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public struct AuthToken: Equatable {
    public let userId: String
    public let token: String
    
    public init(
        userId: String,
        token: String
    ) {
        self.userId = userId
        self.token = token
    }
}
