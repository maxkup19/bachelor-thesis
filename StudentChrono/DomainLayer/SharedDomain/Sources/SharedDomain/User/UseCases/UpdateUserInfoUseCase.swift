//
//  UpdateUserInfoUseCase.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import Spyable

@Spyable
public protocol UpdateUserInfoUseCase {
    func execute(_ payload: UpdateUserInfoData) async throws
}

public struct UpdateUserInfoUseCaseImpl: UpdateUserInfoUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ payload: UpdateUserInfoData) async throws {
        try await userRepository.updateUserInfo(payload)
    }
}
