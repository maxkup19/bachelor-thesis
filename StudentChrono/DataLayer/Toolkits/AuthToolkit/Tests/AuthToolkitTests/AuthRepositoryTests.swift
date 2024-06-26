//
//  AuthRepositoryTests.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

@testable import AuthToolkit
import KeychainProvider
import KeychainProviderMocks
import NetworkProvider
import NetworkProviderMocks
import SharedDomain
import SharedDomainMocks
import Utilities
import XCTest

final class AuthRepositoryTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let keychainProvider = KeychainProviderMock()
    private let networkProvider = NetworkProviderMock()
    
    private func createRepository() -> AuthRepository {
        AuthRepositoryImpl(
            keychainProvider: keychainProvider,
            networkProvider: networkProvider
        )
    }
    
    // MARK: Tests
    
    func testLoginValid() async throws {
        let repository = createRepository()
        networkProvider.requestReturnData = try JSONEncoder().encode(AuthToken.stub)
        
        try await repository.login(.stubValid)
        
        XCTAssertEqual(networkProvider.requestCallsCount, 1)
        XCTAssert(keychainProvider.updateValueReceivedInvocations == [
            (.authToken, AuthToken.stub.token),
            (.userId, AuthToken.stub.userId)
        ])
    }
    
    func testLoginInvalidPassword() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = NetworkProviderError.requestFailed(statusCode: .unauthorised, message: "")
        
        do {
            _ = try await repository.login(.stubValid)
            
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? AuthError, .login(.invalidCredentials))
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
            XCTAssertEqual(keychainProvider.updateValueCallsCount, 0)
        }
    }
    
    func testRegistrationValid() async throws {
        let repository = createRepository()
        networkProvider.requestReturnData = try JSONEncoder().encode(AuthToken.stub)
         
        try await repository.registration(.stubValid)

        XCTAssertEqual(networkProvider.requestCallsCount, 1)
    }
    
    func testRegistrationExistingEmail() async throws {
        let repository = createRepository()
        networkProvider.requestReturnError = NetworkProviderError.requestFailed(statusCode: .conflict, message: "")
        
        do {
            _ = try await repository.registration(.stubValid)
            
            XCTFail("Should throw")
        } catch {
            XCTAssertEqual(error as? AuthError, .registration(.userAlreadyExists))
            XCTAssertEqual(networkProvider.requestCallsCount, 1)
        }
    }
    
    func testReadProfileId() throws {
        let repository = createRepository()
        keychainProvider.readReturnValue = AuthToken.stub.userId
        
        let profileId = try repository.readProfileId()
        
        XCTAssertEqual(profileId, AuthToken.stub.userId)
        XCTAssert(keychainProvider.readReceivedInvocations == [.userId])
    }
    
    func testLogout() throws {
        let repository = createRepository()
        
        try repository.logout()
        
        XCTAssertEqual(keychainProvider.deleteAllCallsCount, 1)
    }
}

