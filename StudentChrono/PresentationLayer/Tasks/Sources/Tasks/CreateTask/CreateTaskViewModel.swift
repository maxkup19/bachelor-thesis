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
    
    typealias Task = _Concurrency.Task
    
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
        var taskDetails: TaskDetails = .init()
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case createTask
        case titleChanged(String)
        case descriptionChanged(String)
        case taskDetailsChanged(TaskDetails)
        case cancelTap
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .createTask: await createTask()
            case .titleChanged(let title): titleChanged(title)
            case .descriptionChanged(let description): descriptionChanged(description)
            case .taskDetailsChanged(let details): taskDetailsChanged(details)
            case .cancelTap: cancelTap()
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
                tags: state.taskDetails.tags,
                assigneeId: state.taskDetails.assigneeId,
                dueTo: state.taskDetails.dueTo,
                priority: state.taskDetails.priority
            )
            try await createTaskUseCase.execute(data)
            flowController?.handleFlow(TasksFlow.tasks(.closeCreateTask))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func titleChanged(_ title: String) {
        state.title = title
    }
    
    private func descriptionChanged(_ description: String) {
        state.description = description
    }
    
    private func taskDetailsChanged(_ details: TaskDetails) {
        state.taskDetails = details
    }
    
    private func cancelTap() {
        flowController?.handleFlow(TasksFlow.tasks(.closeCreateTask))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
