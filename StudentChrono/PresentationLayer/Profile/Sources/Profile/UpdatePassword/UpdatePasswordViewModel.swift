//
//  UpdatePasswordViewModel.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit

final class UpdatePasswordViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    init(flowController: FlowController?) {
        self.flowController = flowController
    }
    
    // MARK: - Lifecycle
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            
        })
    }
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var viewState: UpdatePasswordState = .verify
        
        var currentPassword: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case currentPasswordChanged(String)
        case currentPasswordSubmit
        case changePassword
        case cancelTap
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .currentPasswordChanged(let currentPassword): currentPasswordChanged(currentPassword)
            case .currentPasswordSubmit: currentPasswordSubmit()
            case .changePassword: changePassword()
            case .cancelTap: cancelTap()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func currentPasswordChanged(_ currentPassword: String) {
        state.currentPassword = currentPassword
    }
    
    private func currentPasswordSubmit() {
#warning("TODO: call verify current poassword")
    }
    
    private func changePassword() {
#warning("TODO: call Change password use case")
    }
    
    private func cancelTap() {
#warning("TODO: add flow handler")
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
