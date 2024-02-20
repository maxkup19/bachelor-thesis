//
//  AuthRepository.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol AuthRepository {
    func login(_ payload: LoginData) async throws
    func registration(_ payload: RegistrationData) async throws
    func readProfileId() throws -> String
    func logout() throws
}
