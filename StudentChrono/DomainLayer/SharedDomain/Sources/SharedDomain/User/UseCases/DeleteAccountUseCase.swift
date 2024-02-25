//
//  DeleteAccountUseCase.swift
//
//
//  Created by Maksym Kupchenko on 25.02.2024.
//

import Spyable

@Spyable
public protocol DeleteAccountUseCase {
    func execute() async throws
}

public struct DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    
    private let userRepository: UserRepository
    private let logoutUseCase: LogoutUseCase
    
    public init(
        userRepository: UserRepository,
        logoutUseCase: LogoutUseCase
    ) {
        self.userRepository = userRepository
        self.logoutUseCase = logoutUseCase
    }
    
    public func execute() async throws {
        try await userRepository.deleteAccount()
        try logoutUseCase.execute()
    }
}
