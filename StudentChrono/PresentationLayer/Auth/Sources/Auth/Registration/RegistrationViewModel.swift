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
        var isLoading: Bool = false
        var toastData: ToastData?
    }
    
    // MARK: - Intent
    
    enum Intent {
        case showLogin
        case dismissToast
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .showLogin: showLogin()
            case .dismissToast: dismissToast()
            }
        })
    }
    
    // MARK: - Private
    
    private func showLogin() {
        flowController?.handleFlow(AuthFlow.auth(.showLogin))
    }
    
    private func dismissToast() {
        state.toastData = nil
    }
    
}

