//
//  IsUserLoggedUseCase.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Spyable

@Spyable
public protocol IsUserLoggedUseCase {
    func execute() -> Bool
}

public struct IsUserLoggedUseCaseImpl: IsUserLoggedUseCase {
    
    private let getProfileIdUseCase: GetProfileIdUseCase
    
    public init(getProfileIdUseCase: GetProfileIdUseCase) {
        self.getProfileIdUseCase = getProfileIdUseCase
    }
    
    public func execute() -> Bool {
        do {
            _ = try getProfileIdUseCase.execute()
            return true
        } catch { return false }
    }
}
