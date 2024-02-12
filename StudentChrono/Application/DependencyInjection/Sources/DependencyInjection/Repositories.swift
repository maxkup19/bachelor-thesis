//
//  Repositories.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import AuthToolkit
import Factory
import SharedDomain

public extension Container {
    var authRepository: Factory<AuthRepository> { self { AuthRepositoryImpl(
        keychainProvider: self.keychainProvider(),
        networkProvider: self.networkProvider()
    )}}
}
