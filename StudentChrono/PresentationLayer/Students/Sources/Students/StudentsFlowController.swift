//
//  StudentsFlowController.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum StudentsFlow: Flow, Equatable {
    case students(Students)
    
    enum Students: Equatable {
        case showStudentDetail(String)
        case showTaskDetail(String)
    }
}

public protocol StudentsFlowControllerDelegate: AnyObject {
    func showTaskDetail(id: String)
}

public final class StudentsFlowController: FlowController {
    
    public weak var delegate: StudentsFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = StudentsViewModel(flowController: self)
        return BaseHostingController(rootView: StudentsView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let studentsFlow = flow as? StudentsFlow else { return }
        switch studentsFlow {
        case .students(let students): handleFlow(students)
        }
    }
    
}

// MARK: - Students Flow
extension StudentsFlowController {
    func handleFlow(_ flow: StudentsFlow.Students) {
        switch flow {
        case .showStudentDetail(let id): showStudentDetail(id: id)
        case .showTaskDetail(let id): delegate?.showTaskDetail(id: id)
        }
    }
    
    private func showStudentDetail(id: String) {
        let vm = StudentDetailViewModel(studentId: id, flowController: self)
        let view = StudentDetailView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.title = "Student Detail"
        
        navigationController.show(vc, sender: nil)
    }
}
