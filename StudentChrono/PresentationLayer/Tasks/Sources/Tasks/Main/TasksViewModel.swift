//
//  TasksViewModel.swift
//  
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class TasksViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    
    
    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
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
        case onTaskTap(String)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .onTaskTap(let taskId): onTaskTap(taskId: taskId)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    private func onTaskTap(taskId: String) {
        #warning("TODO: add implementation")
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
