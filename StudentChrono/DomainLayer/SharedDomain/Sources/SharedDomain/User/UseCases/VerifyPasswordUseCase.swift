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
    
    private let userRepoisitory: UserRepository
    
    public init(userRepoisitory: UserRepository) {
        self.userRepoisitory = userRepoisitory
    }
    
    public func execute(_ payload: UpdatePasswordData) async -> Bool {
        do {
            try await userRepoisitory.verifyPassword(payload)
            return true
        } catch { return false }
    }
    
}
