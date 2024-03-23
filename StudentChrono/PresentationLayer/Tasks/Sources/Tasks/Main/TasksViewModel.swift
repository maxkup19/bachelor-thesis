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

final class TasksViewModel: BaseViewModel, ViewModel, ObservableObject, TaskDetailOpenerDelegate {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getCurrentUserRoleUseCase) private var getCurrentUserRoleUseCase
    @Injected(\.getMyTasksUseCase) private var getMyTasksUseCase
    
    init(flowController: FlowController?) {
        super.init()
        self.flowController = flowController
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
        var tasks: [SharedDomain.Task] = []
        var showCreateButtonTask: Bool = false
        var searchText: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case createTask
        case refreshTasks
        case searchTextChanged(String)
        case onTaskTap(String)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .createTask: createTask()
            case .refreshTasks: await refreshTasks()
            case .searchTextChanged(let text): searchTextChanged(text)
            case .onTaskTap(let taskId): onTaskTap(taskId: taskId)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.showCreateButtonTask = try await getCurrentUserRoleUseCase.execute() == .teacher
            state.tasks = try await getMyTasksUseCase.execute()
            #warning("UI improvement?")
//            try? await Task.sleep(nanoseconds: 200_000_000)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func createTask() {
        flowController?.handleFlow(TasksFlow.tasks(.createTask))
    }
    
    private func refreshTasks() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.tasks = try await getMyTasksUseCase.execute()
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func searchTextChanged(_ text: String) {
        state.searchText = text
    }
    
    private func onTaskTap(taskId: String) {
        flowController?.handleFlow(TasksFlow.tasks(.showTaskDetail(taskId)))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
    public func presentTaskDetail(for id: String) {
        onTaskTap(taskId: id)
    }
}
