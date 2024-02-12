//
//  UseCaseMocks.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

#if DEBUG

import DependencyInjection
import Factory
@testable import SharedDomain
import SharedDomainMocks

public extension Container {
    func registerUseCaseMocks() {
        // Auth
        let getProfileIdUseCaseSpy = GetProfileIdUseCaseSpy()
        getProfileIdUseCaseSpy.executeReturnValue = AuthToken.stub.userId
        getProfileIdUseCase.register { getProfileIdUseCaseSpy }
        
        let isUserLoggedUseCaseSpy = IsUserLoggedUseCaseSpy()
        isUserLoggedUseCaseSpy.executeReturnValue = true
        isUserLoggedUseCase.register { isUserLoggedUseCaseSpy }
        
        loginUseCase.register { LoginUseCaseSpy() }
        logoutUseCase.register { LogoutUseCaseSpy() }
        registrationUseCase.register { RegistrationUseCaseSpy() }
    }
}
#endif
