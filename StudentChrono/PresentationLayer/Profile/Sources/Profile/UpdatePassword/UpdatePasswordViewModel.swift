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
    
    @Injected(\.verifyPasswordUseCase) private var verifyPasswordUseCase
    @Injected(\.updatePasswordUseCase) private var updatePasswordUseCase
    
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
        var newPassword: String = ""
        var verifyNewPassword: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
        
        var toolbarButtonDisabled: Bool {
            switch viewState {
            case .verify: currentPassword.isEmpty
            case .change: newPassword.isEmpty || verifyNewPassword.isEmpty
            }
        }
    }
    
    // MARK: - Intents
    enum Intent {
        case currentPasswordChanged(String)
        case currentPasswordSubmit
        case newPasswordChanged(String)
        case verifyNewPasswordChanged(String)
        case changePassword
        case cancelTap
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .currentPasswordChanged(let currentPassword): currentPasswordChanged(currentPassword)
            case .currentPasswordSubmit: await currentPasswordSubmit()
            case .newPasswordChanged(let newPassword): newPasswordChanged(newPassword)
            case .verifyNewPasswordChanged(let verifyNewPasswor): verifyNewPasswordChanged(verifyNewPasswor)
            case .changePassword: await changePassword()
            case .cancelTap: cancelTap()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func currentPasswordChanged(_ currentPassword: String) {
        state.currentPassword = currentPassword
    }
    
    private func currentPasswordSubmit() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        guard await verifyPasswordUseCase.execute(state.currentPassword) else {
            state.alertData = .init(title: "Wrong Password")
            return
        }
        
        withAnimation {
            state.viewState = .change
        }
    }
    
    private func newPasswordChanged(_ newPassword: String) {
        state.newPassword = newPassword
    }
    
    private func verifyNewPasswordChanged(_ verifyNewPassword: String) {
        state.verifyNewPassword = verifyNewPassword
    }
    
    private func changePassword() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        guard state.newPassword == state.verifyNewPassword else {
            state.alertData = .init(title: "Password are not the same")
            return
        }
        
        do {
            try await updatePasswordUseCase.execute(UpdatePasswordData(password: state.newPassword))
            flowController?.handleFlow(ProfileFlow.profile(.dismissSheet))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
        
    }
    
    private func cancelTap() {
        flowController?.handleFlow(ProfileFlow.profile(.dismissSheet))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
