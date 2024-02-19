//
//  AuthFlowController.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum AuthFlow: Flow, Equatable {
    case auth(Auth)
    case login(Login)
    case registration(Registration)
    
    enum Auth: Equatable {
        case showLogin
        case showRegistration
    }
    
    enum Login: Equatable {
        case login
    }
    
    enum Registration: Equatable {
        case register
    }
}

public protocol AuthFlowControllerDelegate: AnyObject {
    func setupMain()
}

public final class AuthFlowController: FlowController {
    
    public weak var delegate: AuthFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = LoginViewModel(flowController: self)
        return BaseHostingController(rootView: LoginView(viewModel: vm), statusBarStyle: .lightContent)
    }
    
    override public func dismiss() {
        super.dismiss()
        delegate?.setupMain()
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let authFlow = flow as? AuthFlow else { return }
        switch authFlow {
        case .auth(let authFlow): handleAuthFlow(authFlow)
        case .login(let loginFlow): handleLoginFlow(loginFlow)
        case .registration(let registrationFlow): handleRegistrationFlow(registrationFlow)
        }
    }
}

// MARK: Auth flow
extension AuthFlowController {
    func handleAuthFlow(_ flow: AuthFlow.Auth) {
        switch flow {
        case .showLogin: showLogin()
        case .showRegistration: showRegistration()
        }
    }
    
    private func showLogin() {
        let vm = LoginViewModel(flowController: self)
        let vc = BaseHostingController(rootView: LoginView(viewModel: vm), statusBarStyle: .lightContent)
        navigationController.show(vc, sender: nil)
    }
    
    private func showRegistration() {
        let vm = RegistrationViewModel(flowController: self)
        let vc = BaseHostingController(rootView: RegistrationView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Login flow
extension AuthFlowController {
    func handleLoginFlow(_ flow: AuthFlow.Login) {
        switch flow {
        case .login: dismiss()
        }
    }
}

// MARK: Registration flow
extension AuthFlowController {
    func handleRegistrationFlow(_ flow: AuthFlow.Registration) {
        switch flow {
        case .register: register()
        }
    }
    
    private func register() {
        let vm = RegistrationViewModel(flowController: self)
        let vc = BaseHostingController(rootView: RegistrationView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}
