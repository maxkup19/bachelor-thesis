//
//  ProfileViewModel.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class ProfileViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
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
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case showDeleteAccountDialog
        case deleteAccount
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .showDeleteAccountDialog: showDeleteAccountDialog()
            case .deleteAccount: await deleteAccount()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func showDeleteAccountDialog() {
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
            flowController?.handleFlow(ProfileFlow.profile(.deleteAccount))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
}
