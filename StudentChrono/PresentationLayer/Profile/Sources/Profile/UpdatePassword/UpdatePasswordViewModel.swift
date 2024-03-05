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
        
        var viewState: ViewState = .verify
        var isLoading: Bool = false
        var alertData: AlertData?
        
        enum ViewState {
            case verify
            case update
        }
    }
    
    // MARK: - Intents
    enum Intent {
        case cancelTap
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .cancelTap: cancelTap()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func cancelTap() {
        
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
