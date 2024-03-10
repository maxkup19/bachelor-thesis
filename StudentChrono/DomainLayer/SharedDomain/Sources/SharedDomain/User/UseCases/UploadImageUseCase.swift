//
//  UploadImageUseCase.swift
//
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Spyable

@Spyable
public protocol UploadImageUseCase {
    func execute(_ payload: File) async throws -> User
}

public struct UploadImageUseCaseImpl: UploadImageUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func execute(_ payload: File) async throws -> User {
        try await userRepository.uploadUserImage(payload)
    }
}
