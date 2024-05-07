//
//  UserRepository.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import FirebaseStorage
import NetworkProvider
import SharedDomain

public struct UserRepositoryImpl: UserRepository {
    
    private let network: NetworkProvider
    private let storage: Storage
    
    public init(
        networkProvider: NetworkProvider
    ) {
        network = networkProvider
        storage = Storage.storage()
    }
    
    public func getCurrentUser() async throws -> User {
        do {
            return try await network.request(UserAPI.currentUser, withInterceptor: false)
                .map(NETUser.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
    public func updateUserInfo(_ payload: UpdateUserInfoData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(UserAPI.updateInfo(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
    public func verifyPassword(_ payload: UpdatePasswordData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(UserAPI.verifyPassword(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
    public func updatePassword(_ payload: UpdatePasswordData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(UserAPI.updatePassword(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
    public func uploadUserImage(_ payload: File) async throws -> User {
        do {
            let reference = storage.reference().child(payload.filename)
            let _ = try await reference.putDataAsync(payload.data)
            let fileURL = try await reference.downloadURL().absoluteString
            
            let data = try NETFile(filename: fileURL).encode()
            return try await network.request(UserAPI.uploadUserImage(data), withInterceptor: false)
                .map(NETUser.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
    public func deleteAccount() async throws {
        do {
            try await network.request(UserAPI.deleteAccount, withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw UserError.userError(description: message?.reason)
        }
    }
    
}
