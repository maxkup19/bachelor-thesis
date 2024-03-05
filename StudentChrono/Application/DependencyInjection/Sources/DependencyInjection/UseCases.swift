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
    var getCurrentUserUseCase: Factory<GetCurrentUserUseCase> { self { GetCurrentUserUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    var getCurrentUserRoleUseCase: Factory<GetCurrentUserRoleUseCase> { self { GetCurrentUserRoleUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    var updateUserInfoUseCase: Factory<UpdateUserInfoUseCase> { self { UpdateUserInfoUseCaseImpl(
        userRepository: self.userRepository()
    )}}
    var verifyPasswordUseCase: Factory<VerifyPasswordUseCase> { self { VerifyPasswordUseCaseImpl(
        userRepoisitory: self.userRepository()
    )}}
    var deleteAccountUseCase: Factory<DeleteAccountUseCase> { self { DeleteAccountUseCaseImpl(
        userRepository: self.userRepository(),
        logoutUseCase: self.logoutUseCase()
    )}}
    
    // Tasks
    var createTaskUseCase: Factory<CreateTaskUseCase> { self { CreateTaskUseCaseImpl(
        taskRepository: self.taskRepository()
    )}}
    var getMyTasksUseCase: Factory<GetMyTasksUseCase> { self { GetMyTasksUseCaseImpl(
        taskRepository: self.taskRepository()
    )}}
    
    // Students
    var addStudentUseCase: Factory<AddStudentUseCase> { self { AddStudentUseCaseImpl(
        studentsRepository: self.studentsRepository(),
        validateEmailUseCase: self.validateEmailUseCase()
    )}}
    var getMyStudentsUseCase: Factory<GetMyStudentsUseCase> { self { GetMyStudentsUseCaseImpl(
        studentsRepository: self.studentsRepository()
    )}}
    
    // Validation
    var validateEmailUseCase: Factory<ValidateEmailUseCase> { self { ValidateEmailUseCaseImpl() } }
    var validatePasswordUseCase: Factory<ValidatePasswordUseCase> { self { ValidatePasswordUseCaseImpl() } }
}
