//
//  RegistrationUseCase.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol RegistrationUseCase {
    func execute(_ data: RegistrationData) async throws
}

public struct RegistrationUseCaseImpl: RegistrationUseCase {
    
    private let authRepository: AuthRepository
    private let validateEmailUseCase: ValidateEmailUseCase
    private let validatePasswordUseCase: ValidatePasswordUseCase
    
    public init(
        authRepository: AuthRepository,
        validateEmailUseCase: ValidateEmailUseCase,
        validatePasswordUseCase: ValidatePasswordUseCase
    ) {
        self.authRepository = authRepository
        self.validateEmailUseCase = validateEmailUseCase
        self.validatePasswordUseCase = validatePasswordUseCase
    }
    
    public func execute(_ data: RegistrationData) async throws {
        try validateEmailUseCase.execute(data.email)
        try validatePasswordUseCase.execute(data.password)
        _ = try await authRepository.registration(data)
    }
}
