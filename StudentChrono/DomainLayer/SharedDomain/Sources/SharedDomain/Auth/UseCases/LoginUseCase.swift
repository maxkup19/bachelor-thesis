//
//  LoginUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol LoginUseCase {
    func execute(_ data: LoginData) async throws
}

public struct LoginUseCaseImpl: LoginUseCase {
    
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
    
    public func execute(_ data: LoginData) async throws {
        try validateEmailUseCase.execute(data.email)
        try validatePasswordUseCase.execute(data.password)
        _ = try await authRepository.login(data)
    }
}
