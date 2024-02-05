//
//  ValidatePasswordUseCase.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Spyable

@Spyable
public protocol ValidatePasswordUseCase {
    func execute(_ password: String) throws
}

public struct ValidatePasswordUseCaseImpl: ValidatePasswordUseCase {
    
    public init() {}
    
    public func execute(_ password: String) throws {
        if password.isEmpty {
            throw ValidationError.password(.isEmpty)
        }
    }
}
