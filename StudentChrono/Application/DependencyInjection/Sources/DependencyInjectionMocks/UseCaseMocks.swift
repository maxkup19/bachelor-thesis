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
        
        // User
        let getCurrentUserUseCaseSpy = GetCurrentUserUseCaseSpy()
        getCurrentUserUseCaseSpy.executeReturnValue = User.studentStub
        getCurrentUserUseCase.register { getCurrentUserUseCaseSpy }
        
        let getCurrentUserRoleUseCaseSpy = GetCurrentUserRoleUseCaseSpy()
        getCurrentUserRoleUseCaseSpy.executeReturnValue = User.studentStub.role
        getCurrentUserRoleUseCase.register { getCurrentUserRoleUseCaseSpy }
        
        let verifyPasswordUseCaseSpy = VerifyPasswordUseCaseSpy()
        verifyPasswordUseCaseSpy.executeReturnValue = true
        verifyPasswordUseCase.register { verifyPasswordUseCaseSpy }
        
        deleteAccountUseCase.register { DeleteAccountUseCaseSpy() }
        updateUserInfoUseCase.register { UpdateUserInfoUseCaseSpy() }
        
        // Task
        let getMyTasksUseCaseSpy = GetMyTasksUseCaseSpy()
        getMyTasksUseCaseSpy.executeReturnValue = [Task.task2Stub]
        getMyTasksUseCase.register { getMyTasksUseCaseSpy }
        
        createTaskUseCase.register { CreateTaskUseCaseSpy() }
        
        // Students
        let getMyStudentsUseCaseSpy = GetMyStudentsUseCaseSpy()
        getMyStudentsUseCaseSpy.executeReturnValue = [User.studentStub]
        getMyStudentsUseCase.register { getMyStudentsUseCaseSpy }
        
        addStudentUseCase.register { AddStudentUseCaseSpy() }
    }
}
#endif
