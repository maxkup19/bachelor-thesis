//
//  CreateTaskViewModel.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class CreateTaskViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.createTaskUseCase) private var createTaskUseCase
    
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
        var title: String = ""
        var description: String = ""
        var assigneeId: UUID?
        var dueTo: Date?
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case createTask
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .createTask: await createTask()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func createTask() async {
        #warning("Revisit in future")
        do {
            let data = CreateTaskData(
                title: state.title,
                description: state.description,
                assigneeId: state.assigneeId,
                dueTo: state.dueTo
            )
            try await createTaskUseCase.execute(data)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
