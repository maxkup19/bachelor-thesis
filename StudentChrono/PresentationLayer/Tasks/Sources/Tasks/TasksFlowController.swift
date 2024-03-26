//
//  TasksFlowController.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SharedDomain
import SwiftUI
import UIKit
import UIToolkit

enum TasksFlow: Flow, Equatable {
    case tasks(Tasks)
    
    enum Tasks: Equatable {
        case createTask
        case closeCreateTask
        case showTaskDetail(String, SharedDomain.Task?)
        case addComment(String)
    }
}

public protocol TaskDetailOpenerDelegate: AnyObject {
    func presentTaskDetail(for id: String)
}

public final class TasksFlowController: FlowController, TaskDetailOpenerDelegate {
    
    weak var taskDetailOpener: TaskDetailOpenerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = TasksViewModel(flowController: self)
        taskDetailOpener = vm
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
    
    public func presentTaskDetail(for id: String) {
        taskDetailOpener?.presentTaskDetail(for: id)
    }
}

// MARK: - Tasks Flow
extension TasksFlowController {
    func handleFlow(_ flow: TasksFlow.Tasks) {
        switch flow {
        case .createTask: createTask()
        case .closeCreateTask: dismiss()
        case let .showTaskDetail(id, task): task?.state == .draft ? createTask(task: task) : showTaskDetail(id: id)
        case .addComment(let id): addComment(id: id)
        }
    }
    
    private func createTask(task: SharedDomain.Task? = nil) {
        let vm = CreateTaskViewModel(task: task, flowController: self)
        let view = CreateTaskView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.modalPresentationStyle = .automatic
        
        navigationController.present(vc, animated: true)
    }
    
    private func showTaskDetail(id: String) {
        let vm = TaskDetailViewModel(
            taskId: id,
            flowController: self
        )
        let view = TaskDetailView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.title = "Task Detail"
        
        navigationController.show(vc, sender: nil)
    }
    
    private func addComment(id: String) {
        let vm = AddCommentViewModel(
            taskId: id,
            flowController: self
        )
        let view = AddComentView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.title = "Add Comment"
        
        navigationController.show(vc, sender: nil)
    }
}
