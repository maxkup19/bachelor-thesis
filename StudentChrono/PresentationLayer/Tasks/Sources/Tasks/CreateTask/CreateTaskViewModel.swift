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
    @Injected(\.getMyStudentsUseCase) private var getMyStudentsUseCase
    
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
        var title: String = ""
        var description: String = ""
        var taskDetails: TaskDetails = .init()
        var students: [User] = []
        var selectedStudentIds: Set<String> = []
        var isLoading: Bool = false
        var alertData: AlertData?
        
        var selectedStudentFullName: String {
            guard let student = students.first(where: { $0.id == selectedStudentIds.first }) else { return "" }
            return "\(student.name) \(student.lastName)"
        }
    }
    
    // MARK: - Intents
    enum Intent {
        case createTask
        case titleChanged(String)
        case descriptionChanged(String)
        case taskDetailsChanged(TaskDetails)
        case selectedStudentIdsChanged(Set<String>)
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
            case .selectedStudentIdsChanged(let students): selectedStudentChanged(students)
            case .cancelTap: cancelTap()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.students = try await getMyStudentsUseCase.execute()
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func createTask() async {
        do {
            let data = CreateTaskData(
                title: state.title,
                description: state.description,
                tags: state.taskDetails.tags,
                assigneeId: state.selectedStudentIds.first,
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
    
    private func selectedStudentChanged(_ students: Set<String> ) {
        let newSelected = students.subtracting(state.selectedStudentIds)
        state.selectedStudentIds = newSelected
    }
    
    private func cancelTap() {
        flowController?.handleFlow(TasksFlow.tasks(.closeCreateTask))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
