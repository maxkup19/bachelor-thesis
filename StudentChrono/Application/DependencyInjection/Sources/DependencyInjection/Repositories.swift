//
//  Repositories.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import AuthToolkit
import Factory
import SharedDomain
import UserToolkit

public extension Container {
    var authRepository: Factory<AuthRepository> { self { AuthRepositoryImpl(
        keychainProvider: self.keychainProvider(),
        networkProvider: self.networkProvider()
    )}}
    var userRepository: Factory<UserRepository> { self { UserRepositoryImpl(
        network: self.networkProvider()
    )}}
}
