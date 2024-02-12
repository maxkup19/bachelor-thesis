//
//  LandingViewModel.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import Utilities

final class LandingViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Depependencies
    
    private weak var flowController: AuthFlowController?
    
    init(flowController: AuthFlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: - Lifecycle
    
    override func onAppear() {
        super.onAppear()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()
    
    struct State {
        var isLoading: Bool = false
    }
    
    // MARK: - Intent
    
    enum Intent {
        case login
        case register
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .login: login()
            case .register: register()
            }
        })
    }
    
    // MARK: - Private
    
    private func login() {
        flowController?.handleFlow(AuthFlow.auth(.showLogin))
    }
    
    private func register() {
        flowController?.handleFlow(AuthFlow.auth(.showRegistration))
    }
}

