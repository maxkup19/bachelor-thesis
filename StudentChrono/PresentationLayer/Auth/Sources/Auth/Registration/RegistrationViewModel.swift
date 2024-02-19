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
        var lastname: String = ""
        var isTeacher: Bool = false
        var isShowingPassword: Bool = false
        var isLoading: Bool = false
        var toastData: ToastData?
    }
    
    // MARK: - Intent
    
    enum Intent {
        case emailChanged(String)
        case passwordChanged(String)
        case showPasswordToggle
        case confirmedPasswordChanged(String)
        case nameChanged(String)
        case lastnameChanged(String)
        case isTeacherToggle
        case registerTap
        case showLogin
        case dismissToast
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .emailChanged(let email): emailChanged(email)
            case .passwordChanged(let password): passwordChanged(password)
            case .showPasswordToggle: showPasswordToggle()
            case .confirmedPasswordChanged(let password): confirmedPasswordChanged(password)
            case .nameChanged(let name): nameChanged(name)
            case .lastnameChanged(let lastname): lastnameChanged(lastname)
            case .isTeacherToggle: isTeacherToggle()
            case .registerTap: await registerTap()
            case .showLogin: showLogin()
            case .dismissToast: dismissToast()
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
    
    private func showPasswordToggle() {
        state.isShowingPassword.toggle()
    }
    
    private func confirmedPasswordChanged(_ password: String) {
        state.confirmedPassword = password
    }
    
    private func nameChanged(_ name: String) {
        state.name = name
    }
    
    private func lastnameChanged(_ lastname: String) {
        state.lastname = lastname
    }
    
    private func isTeacherToggle() {
        state.isTeacher.toggle()
    }
    
    private func registerTap() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        guard state.password == state.confirmedPassword else {
            state.toastData = .init("Passwords dont match")
            return
        }
        
        do {
            let data = RegistrationData(
                email: state.email,
                password: state.password,
                name: state.name,
                lastName: state.lastname,
                role: state.isTeacher ? .teacher : .student
            )
            try await registrationUseCase.execute(data)
            flowController?.handleFlow(AuthFlow.login(.login))
        } catch {
            state.toastData = .init(error: error.localizedDescription)
        }
        
    }
    
    private func showLogin() {
        flowController?.handleFlow(AuthFlow.auth(.showLogin))
    }
    
    private func dismissToast() {
        state.toastData = nil
    }
    
}

