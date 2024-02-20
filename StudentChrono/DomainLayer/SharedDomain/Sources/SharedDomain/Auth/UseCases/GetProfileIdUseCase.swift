//
//  GetProfileIdUseCase.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Spyable

@Spyable
public protocol GetProfileIdUseCase {
    func execute() throws -> String
}

public struct GetProfileIdUseCaseImpl: GetProfileIdUseCase {
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute() throws -> String {
        try authRepository.readProfileId()
    }
}
