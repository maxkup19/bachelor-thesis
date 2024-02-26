//
//  TasksFlowController.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum TasksFlow: Flow, Equatable {
    case tasks(Tasks)
    
    enum Tasks: Equatable {
        case createTask
    }
}

public final class TasksFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = TasksViewModel(flowController: self)
        return BaseHostingController(rootView: TasksView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let tasksFlow = flow as? TasksFlow else { return }
        switch tasksFlow {
        case .tasks(let tasks): handleFlow(tasks)
        }
    }
    
    override public func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

// MARK: - Tasks Flow
extension TasksFlowController {
    func handleFlow(_ flow: TasksFlow.Tasks) {
        switch flow {
        case .createTask: createTask()
        }
    }
    
    private func createTask() {
        let vm = CreateTaskViewModel(flowController: self)
        let view = CreateTaskView(viewModel: vm)
        
        let vc = BaseHostingBottomSheetController(rootView: view) { [weak self] in
            self?.dismiss()
        }
        navigationController.present(vc, animated: true)
    }
}
