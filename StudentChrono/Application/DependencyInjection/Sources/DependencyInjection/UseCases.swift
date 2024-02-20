//
//  UseCases.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Factory
import SharedDomain

public extension Container {
    
    // Auth
    var getProfileIdUseCase: Factory<GetProfileIdUseCase> { self { GetProfileIdUseCaseImpl (
        authRepository: self.authRepository()
    )}}
    var isUserLoggedUseCase: Factory<IsUserLoggedUseCase> { self { IsUserLoggedUseCaseImpl(
        getProfileIdUseCase: self.getProfileIdUseCase()
    )}}
    var loginUseCase: Factory<LoginUseCase> { self { LoginUseCaseImpl(
        authRepository: self.authRepository(),
        validateEmailUseCase: self.validateEmailUseCase(),
        validatePasswordUseCase: self.validatePasswordUseCase()
    )}}
    var logoutUseCase: Factory<LogoutUseCase> { self { LogoutUseCaseImpl(
        authRepository: self.authRepository()
    )}}
    var registrationUseCase: Factory<RegistrationUseCase> { self { RegistrationUseCaseImpl(
        authRepository: self.authRepository(),
        validateEmailUseCase: self.validateEmailUseCase(),
        validatePasswordUseCase: self.validatePasswordUseCase()
    )}}
    
    // Users
    var getCurrentUserRoleUseCase: Factory<GetCurrentUserRoleUseCase> { self { GetCurrentUserRoleUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    
    // Validation
    var validateEmailUseCase: Factory<ValidateEmailUseCase> { self { ValidateEmailUseCaseImpl() } }
    var validatePasswordUseCase: Factory<ValidatePasswordUseCase> { self { ValidatePasswordUseCaseImpl() } }
}
