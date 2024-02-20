//
//  LoginViewModel.swift
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

final class LoginViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.loginUseCase) private var loginUseCase
    
    init(flowController: FlowController?) {
        super.init()
        self.flowController = flowController
    }
    
    // MARK: - State
    
    @Published private(set) var state = State()
    
    struct State {
        var email: String = ""
        var password: String = ""
        var isShowingPassword: Bool = false
        var isLoading: Bool = false
        var toastData: ToastData?
    }
    
    // MARK: - Intent
    
    enum Intent {
        case changeEmail(String)
        case changePassword(String)
        case showPasswordToggle
        case login
        case showRegistration
        case dismissToast
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .changeEmail(let email): changeEmail(email)
            case .changePassword(let password): changePassword(password)
            case .showPasswordToggle: showPasswordToggle()
            case .login: await login()
            case .showRegistration: showRegistration()
            case .dismissToast: dismissToast()
            }
        })
    }
    
    // MARK: - Private
    
    private func changeEmail(_ email: String) {
        state.email = email
    }
    
    private func changePassword(_ password: String) {
        state.password = password
    }
    
    private func showPasswordToggle() {
        state.isShowingPassword.toggle()
    }
    
    private func login() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            let data = LoginData(email: state.email, password: state.password)
            try await loginUseCase.execute(data)
            flowController?.handleFlow(AuthFlow.login(.login))
        } catch {
            state.toastData = .init(error: error.localizedDescription)
        }
    }
    
    private func showRegistration() {
        flowController?.handleFlow(AuthFlow.auth(.showRegistration))
    }
    
    private func dismissToast() {
        state.toastData = nil
    }
}
