//
//  UserRepository.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import NetworkProvider
import SharedDomain

public struct UserRepositoryImpl: UserRepository {
    
    private let network: NetworkProvider
    
    public init(
        network: NetworkProvider
    ) {
        self.network = network
    }
    
    public func getCurrentUser() async throws -> User {
        try await network.request(UserAPI.currentUser, withInterceptor: false).map(NETUser.self).domainModel
    }
    
}
