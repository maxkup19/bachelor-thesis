//
//  AuthRepository.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol AuthRepository {
    func login(_ data: LoginData) async throws
    func registration(_ data: RegistrationData) async throws
    func readProfileId() throws -> String
    func logout() throws
}
