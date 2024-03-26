//
//  TaskDetailViewModel.swift
//
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit

final class TaskDetailViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private let taskId: String
    private weak var flowController: FlowController?
    
    @Injected(\.getTaskByIdUseCase) private var getTaskByIdUseCase
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    
    init(
        taskId: String,
        flowController: FlowController?
    ) {
        self.taskId = taskId
        self.flowController = flowController
        super.init()
    }
    
    // MARK: - Lifecycle
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            await loadData()
        })
    }
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var task: SharedDomain.Task = .task1Stub
        var user: User = .teacherStub
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case addComment
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .addComment: addComment()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.user = try await getCurrentUserUseCase.execute()
            state.task = try await getTaskByIdUseCase.execute(taskId: taskId)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func addComment() {
        flowController?.handleFlow(TasksFlow.tasks(.addComment(state.task.id)))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
