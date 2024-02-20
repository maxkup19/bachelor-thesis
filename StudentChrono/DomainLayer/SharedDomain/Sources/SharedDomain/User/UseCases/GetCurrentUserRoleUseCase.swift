//
//  GetCurrentUserRoleUseCase.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Spyable

@Spyable
public protocol GetCurrentUserRoleUseCase {
    func execute() async throws -> UserRoleEnum
}

public struct GetCurrentUserRoleUseCaseImpl: GetCurrentUserRoleUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute() async throws -> UserRoleEnum {
        try await userRepository.getCurrentUser().role
    }
}
