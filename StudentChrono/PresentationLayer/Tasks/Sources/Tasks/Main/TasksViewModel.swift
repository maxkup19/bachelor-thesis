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
    
    @Injected(\.getCurrentUserRoleUseCase) private var getCurrentUserRoleUseCase
    @Injected(\.createTaskUseCase) private var createTaskUseCase
    
    init(flowController: FlowController?) {
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
        var showCreateButtonTask: Bool = false
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case createTask
        case onTask(String)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .createTask: createTask()
            case .onTask(let taskId): onTask(taskId: taskId)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        do {
            state.showCreateButtonTask = try await getCurrentUserRoleUseCase.execute() == .teacher
        } catch { }
    }
    
    private func createTask() {
        
    }
    
    private func onTask(taskId: String) {
        #warning("TODO: add implementation")
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
