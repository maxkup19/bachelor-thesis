//
//  UserRepository.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Spyable

@Spyable
public protocol UserRepository {
    func getCurrentUser() async throws -> User
}