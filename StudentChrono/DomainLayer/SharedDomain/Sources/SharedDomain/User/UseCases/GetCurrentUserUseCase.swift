//
//  GetCurrentUserUseCase.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Spyable

@Spyable
public protocol GetCurrentUserUseCase {
    func execute() async throws -> User
}

public struct GetCurrentUserUseCaseImpl: GetCurrentUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute() async throws -> User {
        try await userRepository.getCurrentUser()
    }
}
