//
//  OthersViewModel.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class OthersViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.logoutUseCase) private var logoutUseCase
    @Injected(\.verifyPasswordUseCase) private var verifyPasswordUseCase
    @Injected(\.deleteAccountUseCase) private var deleteAccountUseCase
    
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
        var password: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case showDeleteAccountDialog
        case passwordChanged(String)
        case logout
        case dismissAlert
        case deleteAccount
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .showDeleteAccountDialog: await showDeleteAccountDialog()
            case .passwordChanged(let password): passwordChanged(password)
            case .logout: await logout()
            case .deleteAccount: await deleteAccount()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func showDeleteAccountDialog() async {
        
        guard await verifyPasswordUseCase.execute(state.password) else {
            state.alertData = .init(title: "Wrong password")
            return
        }
        
        state.alertData = .init(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This will permanently erase your account.",
            primaryAction: .init(title: "Cancel", style: .cancel, handler: dismissAlert),
            secondaryAction: .init(title: "Delete", style: .destruction, handler: { self.onIntent(.deleteAccount) })
        )
    }
    
    private func deleteAccount() async {
        do {
            try await deleteAccountUseCase.execute()
            flowController?.handleFlow(OthersFlow.others(.deleteAccount))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func logout() async {
        do {
            try logoutUseCase.execute()
            flowController?.handleFlow(OthersFlow.others(.logout))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func passwordChanged(_ password: String) {
        state.password = password
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}

