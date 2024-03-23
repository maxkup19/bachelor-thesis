//
//  StudentDetailViewModel.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit

final class StudentDetailViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private let studentId: String
    private weak var flowController: FlowController?
    
    @Injected(\.getStudentByIdUseCase) private var getStudentByIdUseCase
    @Injected(\.getTasksForStudentUseCase) private var getTasksForStudentUseCase
    
    init(
        studentId: String,
        flowController: FlowController?
    ) {
        self.studentId = studentId
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
    @Published private(set) var state: State = State()
    
    struct State {
        var user: User = User.studentStub
        var tasks: [SharedDomain.Task] = []
        var pickerSelection: Int = 0
        var isLoading: Bool = false
        var alertData: AlertData?
        
        var filteredTasks: [SharedDomain.Task] {
            tasks.filter { pickerSelection == 0 ? $0.state != .done : $0.state == .done }
        }
    }
    
    // MARK: - Intent
    enum Intent {
        case selectionChanged(Int)
        case onTaskTap(String)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .selectionChanged(let selection): selectionChanged(selection)
            case .onTaskTap(let id): onTaskTap(id)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    private func loadData() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.user = try await getStudentByIdUseCase.execute(id: studentId)
            state.tasks = try await getTasksForStudentUseCase.execute(studentId: studentId)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func selectionChanged(_ selection: Int) {
        state.pickerSelection = selection
    }
    
    private func onTaskTap(_ id: String) {
        flowController?.handleFlow(StudentsFlow.students(.showTaskDetail(id)))
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
