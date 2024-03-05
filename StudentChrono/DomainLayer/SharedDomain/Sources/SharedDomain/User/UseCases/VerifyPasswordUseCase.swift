//
//  VerifyPasswordUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import Spyable

@Spyable
public protocol VerifyPasswordUseCase {
    func execute(_ payload: UpdatePasswordData) async -> Bool
}

public struct VerifyPasswordUseCaseImpl: VerifyPasswordUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ payload: UpdatePasswordData) async -> Bool {
        do {
            try await userRepository.verifyPassword(payload)
            return true
        } catch {
            print("DEBUG: \(error)")
            return false }
    }
    
}
