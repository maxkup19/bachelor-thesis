//
//  LogoutUseCase.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Spyable

@Spyable
public protocol LogoutUseCase {
    func execute() async throws
}

public struct LogoutUseCaseImpl: LogoutUseCase {
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute() async throws {
        try authRepository.logout()
    }
}
