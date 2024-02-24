//
//  AuthRepository.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import KeychainProvider
import NetworkProvider
import SharedDomain

public struct AuthRepositoryImpl: AuthRepository {
    
    private let keychain: KeychainProvider
    private let network: NetworkProvider
    
    public init(
        keychainProvider: KeychainProvider,
        networkProvider: NetworkProvider
    ) {
        keychain = keychainProvider
        network = networkProvider
    }
    
    public func login(_ payload: LoginData) async throws {
        do {
            let data = try payload.networkModel.encode()
            let authToken = try await network.request(AuthAPI.login(data), withInterceptor: false).map(NETAuthToken.self).domainModel
            try keychain.update(.authToken, value: authToken.token)
            try keychain.update(.userId, value: authToken.userId)
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .unauthorised {
            throw AuthError.login(.invalidCredentials)
        } catch {
            throw AuthError.login(.failed)
        }
    }
    
    public func registration(_ payload: RegistrationData) async throws {
        do {
            let data = try payload.networkModel.encode()
            let authToken = try await network.request(AuthAPI.registration(data)).map(NETAuthToken.self).domainModel
            try keychain.update(.authToken, value: authToken.token)
            try keychain.update(.userId, value: authToken.userId)
        } catch let NetworkProviderError.requestFailed(statusCode, _) where statusCode == .conflict {
            throw AuthError.registration(.userAlreadyExists)
        } catch {
            throw AuthError.registration(.failed)
        }
    }
    
    public func readProfileId() throws -> String {
        try keychain.read(.userId)
    }
    
    public func logout() throws {
        try keychain.deleteAll()
    }
}
