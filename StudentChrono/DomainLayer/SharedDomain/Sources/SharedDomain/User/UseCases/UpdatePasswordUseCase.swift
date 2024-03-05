//
//  UpdatePasswordUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import Spyable

@Spyable
public protocol UpdatePasswordUseCase {
    func execute(_ payload: UpdatePasswordData) async throws
}

public struct UpdatePasswordUserCaseImpl: UpdatePasswordUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ payload: UpdatePasswordData) async throws {
        try await userRepository.updatePassword(payload)
    }
}
