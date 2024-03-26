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
    private let onSuccess: () -> Void
    
    @Injected(\.createTaskUseCase) private var createTaskUseCase
    @Injected(\.updateTaskUseCase) private var updateTaskUseCase
    @Injected(\.getMyStudentsUseCase) private var getMyStudentsUseCase
    
    init(
        task: SharedDomain.Task? = nil,
        flowController: FlowController?,
        onSuccess: @escaping () -> Void
    ) {
        self.flowController = flowController
        self.state = State(
            task: task,
            title: task?.title ?? "",
            description: task?.description ?? "",
            taskDetails: TaskDetails(
                dueTo: task?.dueTo,
                tags: task?.tags ?? [],
                priority: task?.priority ?? .none
            )
        )
        self.onSuccess = onSuccess
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
    @Published private(set) var state: State
    
    struct State {
        fileprivate var task: SharedDomain.Task?
        var title: String
        var description: String
        var taskDetails: TaskDetails
        var students: [User] = []
        var selectedStudentIds: Set<String> = []
        var isLoading: Bool = false
        var alertData: AlertData?
        
        var selectedStudentFullName: String {
            guard let student = students.first(where: { $0.id == selectedStudentIds.first }) else { return "" }
            return "\(student.name) \(student.lastName)"
        }
        
        var toolbarButtonTitle: String {
            task == nil ? "Add" : "Update"
        }
    }
    
    // MARK: - Intents
    enum Intent {
        case addButtonTap
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
            case .addButtonTap: state.task == nil ? await createTask() : await updateTask()
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
        state.isLoading = true
        defer { state.isLoading = false }
        
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
            onSuccess()
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func updateTask() async {
        guard let task = state.task else { return }
        
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            let data = UpdateTaskData(
                taskId: task.id,
                title: state.title,
                description: state.description,
                tags: state.taskDetails.tags,
                assigneeId: state.selectedStudentIds.first,
                dueTo: state.taskDetails.dueTo,
                priority: state.taskDetails.priority
            )
            try await updateTaskUseCase.execute(data)
            flowController?.handleFlow(TasksFlow.tasks(.closeCreateTask))
            onSuccess()
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
