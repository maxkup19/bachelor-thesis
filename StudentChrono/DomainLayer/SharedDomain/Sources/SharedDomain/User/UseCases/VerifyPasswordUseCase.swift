//
//  VerifyPasswordUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import Spyable

@Spyable
public protocol VerifyPasswordUseCase {
    func execute(_ password: String) async -> Bool
}

public struct VerifyPasswordUseCaseImpl: VerifyPasswordUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ password: String) async -> Bool {
        do {
            try await userRepository.verifyPassword(UpdatePasswordData(password: password))
            return true
        } catch { return false }
    }
    
}
