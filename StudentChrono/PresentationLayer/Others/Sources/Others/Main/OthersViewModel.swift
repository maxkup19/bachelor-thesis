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
        var toastData: ToastData?
    }
    
    // MARK: - Intents
    enum Intent {
        case dismissToast
        case logout
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .dismissToast: dismissToast()
            case .logout: await logout()
            }
        })
    }
    
    // MARK: - Private
    
    private func dismissToast() {
        state.toastData = nil
    }
    
    private func logout() async {
        do {
            try logoutUseCase.execute()
            flowController?.handleFlow(OthersFlow.others(.logout))
        } catch {
            state.toastData = .init(error: error.localizedDescription)
        }
    }
}

