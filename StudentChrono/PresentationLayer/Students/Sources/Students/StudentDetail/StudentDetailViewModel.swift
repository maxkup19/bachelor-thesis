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
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intent
    enum Intent {
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    private func loadData() async {
        do {
            state.user = try await getStudentByIdUseCase.execute(id: studentId)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
