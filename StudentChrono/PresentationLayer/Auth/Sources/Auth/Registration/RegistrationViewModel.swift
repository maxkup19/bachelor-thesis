//
//  RegistrationViewModel.swift
//  
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIKit
import UIToolkit

final class RegistrationViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.registrationUseCase) private var registrationUseCase
    
    init(flowController: FlowController?) {
        super.init()
        self.flowController = flowController
    }
    
    // MARK: - State
    
    @Published private(set) var state = State()
    
    struct State {
        var email: String = ""
        var password: String = ""
        var confirmedPassword: String = ""
        var name: String = ""
        var lastName: String = ""
        var birthDay: Date = .now
        var role: UserRoleEnum = .student
        var isLoading: Bool = false
        var alertData: AlertData?
        
        var buttonDisabled: Bool {
            email.isEmpty || password.isEmpty ||
            confirmedPassword.isEmpty || name.isEmpty || lastName.isEmpty
        }
        
        var showRoleSelector: Bool {
            let age = Calendar.current.dateComponents([.year], from: birthDay, to: .now).year
            return age ?? 0 >= 18
        }
    }
    
    // MARK: - Intent
    
    enum Intent {
        case emailChanged(String)
        case passwordChanged(String)
        case confirmedPasswordChanged(String)
        case nameChanged(String)
        case lastNameChanged(String)
        case birthDayChanged(Date)
        case roleChanged(UserRoleEnum)
        case registerTap
        case showLogin
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .emailChanged(let email): emailChanged(email)
            case .passwordChanged(let password): passwordChanged(password)
            case .confirmedPasswordChanged(let password): confirmedPasswordChanged(password)
            case .nameChanged(let name): nameChanged(name)
            case .lastNameChanged(let lastName): lastNameChanged(lastName)
            case .birthDayChanged(let date): birthDayChanged(date)
            case .roleChanged(let role): roleChanged(role)
            case .registerTap: await registerTap()
            case .showLogin: showLogin()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func emailChanged(_ email: String) {
        state.email = email
    }
    
    private func passwordChanged(_ password: String) {
        state.password = password
    }
    
    private func confirmedPasswordChanged(_ password: String) {
        state.confirmedPassword = password
    }
    
    private func nameChanged(_ name: String) {
        state.name = name
    }
    
    private func lastNameChanged(_ lastName: String) {
        state.lastName = lastName
    }
    
    private func birthDayChanged(_ birthDay: Date) {
        state.birthDay = birthDay
    }
    
    private func roleChanged(_ role: UserRoleEnum) {
        state.role = role
    }
    
    private func registerTap() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        guard state.password == state.confirmedPassword else {
            state.alertData = .init(title: "Passwords don't match")
            return
        }
        
        do {
            let data = RegistrationData(
                email: state.email,
                password: state.password,
                name: state.name,
                lastName: state.lastName,
                birthDay: state.birthDay,
                role: state.role
            )
            try await registrationUseCase.execute(data)
            flowController?.handleFlow(AuthFlow.login(.login(state.role)))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
        
    }
    
    private func showLogin() {
        flowController?.handleFlow(AuthFlow.auth(.showLogin))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
}

