//
//  ValidateEmailUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol ValidateEmailUseCase {
    func execute(_ email: String) throws
}

public struct ValidateEmailUseCaseImpl: ValidateEmailUseCase {
    
    public init() {}
    
    public func execute(_ email: String) throws {
        if email.isEmpty {
            throw ValidationError.email(.isEmpty)
        }
    }
}
