//
//  AuthFlowController.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum AuthFlow {
    case auth(Auth)
    case login(Login)
    case registration(Registration)
    
    enum Auth: Equatable {
        case showLogin
        case showRegistration
        case setupMain
    }
    
    enum Login: Equatable {
        case pop
        case logIn
        case register
        case failedLogin(String)
    }
    
    enum Registration: Equatable {
        case pop
        case showAccount
    }
}

public protocol AuthFlowControllerDelegate: AnyObject {
    func setupMain()
}

public final class AuthFlowController: FlowController {
    
    private let initialView: AuthInitialView
    
    public weak var delegate: AuthFlowControllerDelegate?
    
    public init(initialView: AuthInitialView, navigationController: UINavigationController) {
        self.initialView = initialView
        super.init(navigationController: navigationController)
    }
    
    override public func setup() -> UIViewController {
        switch initialView {
        case .landing:
            let vm = LandingViewModel(flowController: self)
            return BaseHostingController(rootView: LandingView(viewModel: vm), statusBarStyle: .lightContent)
        case .account:
            let vm = AccountViewModel(flowController: self)
            return BaseHostingController(rootView: AccountView(viewModel: vm), statusBarStyle: .lightContent)
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
}

// MARK: Auth flow
extension AuthFlowController {
    func handleAuthFlow(_ flow: AuthFlow.Auth) {
        switch flow {
        case .showLogin: showLogin()
        case .showRegistration: showRegistration()
        case .setupMain: delegate?.setupMain()
        }
    }
    
    private func showLogin() {
        let vm = LoginViewModel(flowController: self)
        let vc = BaseHostingController(rootView: LoginView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
    
    private func showRegistration(failedLogin: Bool = false, email: String = "") {
        let vm = RegistrationViewModel(flowController: self, prefilledEmail: email)
        let vc = BaseHostingController(rootView: RegistrationView(viewModel: vm, failedLogin: failedLogin))
        navigationController.show(vc, sender: nil)
    }
}

// MARK: Login flow
extension AuthFlowController {
    func handleLoginFlow(_ flow: AuthFlow.Login) {
        switch flow {
        case .pop: pop()
        case .logIn: delegate?.setupMain()
        case .register: showRegistration()
        case .failedLogin(let email): showRegistration(failedLogin: true, email: email)
        }
    }
}

// MARK: Registration flow
extension AuthFlowController {
    func handleRegistrationFlow(_ flow: AuthFlow.Registration) {
        switch flow {
        case .pop: pop()
        case .showAccount: showAccount()
        }
    }
    
    private func showAccount() {
        let vm = AccountViewModel(flowController: self)
        let vc = BaseHostingController(rootView: AccountView(viewModel: vm))
        navigationController.show(vc, sender: nil)
    }
}
