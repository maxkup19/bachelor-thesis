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
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case dismissAlert
        case logout
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .dismissAlert: dismissAlert()
            case .logout: await logout()
            }
        })
    }
    
    // MARK: - Private
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
    private func logout() async {
        do {
            try logoutUseCase.execute()
            flowController?.handleFlow(OthersFlow.others(.logout))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
}

