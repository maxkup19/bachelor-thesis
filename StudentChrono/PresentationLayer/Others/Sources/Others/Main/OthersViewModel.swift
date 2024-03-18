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
        case aboutAppTap
        case feedbackTap
        case deleteAccountTap
        case logout
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .aboutAppTap: aboutAppTap()
            case .feedbackTap: feedbackTap()
            case .deleteAccountTap: deleteAccountTap()
            case .logout: await logout()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func aboutAppTap() {
        flowController?.handleFlow(OthersFlow.others(.aboutApp))
    }
    
    private func feedbackTap() {
        flowController?.handleFlow(OthersFlow.others(.feedback))
    }
    
    private func deleteAccountTap() {
        flowController?.handleFlow(OthersFlow.others(.deleteAccount))
    }
     
    private func logout() async {
        do {
            try logoutUseCase.execute()
            flowController?.handleFlow(OthersFlow.others(.logout))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}

