//
//  StudentsViewModel.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class StudentsViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getMyStudentsUseCase) private var getMyStudentsUseCase
    @Injected(\.addStudentUseCase) private var addStudentUseCase
    
    init(flowController: FlowController?) {
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
        var students: [User] = []
        var showAddStudentDialogue: Bool = false
        var addStudentEmail: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case showAddStudentDialogue(Bool)
        case emailChanged(String)
        case addStudent
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .emailChanged(let email): emailChanged(email)
            case .showAddStudentDialogue(let show): showAddStudentDialogue(show)
            case .addStudent: await addStudent()
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
    
    private func emailChanged(_ email: String) {
        state.addStudentEmail = email
    }
    
    private func showAddStudentDialogue(_ showAddStudentDialogue: Bool) {
        state.showAddStudentDialogue = showAddStudentDialogue
    }
    
    private func addStudent() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            try await addStudentUseCase.execute(AddStudentData(email: state.addStudentEmail))
            state.students = try await getMyStudentsUseCase.execute()
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
}
