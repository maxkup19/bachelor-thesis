//
//  LoginUseCaseTests.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

@testable import SharedDomain
import SharedDomainMocks
import XCTest

final class LoginUseCaseTests: XCTestCase {
    
    // MARK: Dependencies
    
    private let authRepository = AuthRepositorySpy()
    private let validateEmailUseCase = ValidateEmailUseCaseSpy()
    private let validatePasswordUseCase = ValidatePasswordUseCaseSpy()
    
    // MARK: Tests
    
    func testExecute() async throws {
        let useCase = LoginUseCaseImpl(
            authRepository: authRepository,
            validateEmailUseCase: validateEmailUseCase,
            validatePasswordUseCase: validatePasswordUseCase
        )
        
        try await useCase.execute(.stubValid)

        XCTAssert(validateEmailUseCase.executeReceivedInvocations == [LoginData.stubValid.email])
        XCTAssert(validatePasswordUseCase.executeReceivedInvocations == [LoginData.stubValid.password])
        XCTAssert(authRepository.loginReceivedInvocations == [.stubValid])
    }
}
