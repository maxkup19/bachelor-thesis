//
//  OthersFlowController.swift
//  
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SharedDomain
import SwiftUI
import UIKit
import UIToolkit

enum OthersFlow: Flow, Equatable {
    case others(Others)
    
    enum Others: Equatable {
        case aboutApp
        case feedback
        case deleteAccount
        case logout
    }
}

public protocol OthersFlowControllerDelegate: AnyObject {
    func logout()
}

public final class OthersFlowController: FlowController {
    
    public weak var delegate: OthersFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = OthersViewModel(flowController: self)
        return BaseHostingController(rootView: OthersView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let othersFlow = flow as? OthersFlow else { return }
        switch othersFlow {
        case .others(let others): handleFlow(others)
        }
    }
    
}

// MARK: - Others Flow
extension OthersFlowController {
    func handleFlow(_ flow: OthersFlow.Others) {
        switch flow {
        case .aboutApp: presentAboutApp()
        case .feedback: presentFeedback()
        case .deleteAccount: presentAccountDelete()
        case .logout: delegate?.logout()
        }
    }
    
    private func presentFeedback() {
        let vm = FeedbackViewModel(flowController: self)
        let view = FeedbackView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.title = "Feedback"
        navigationController.show(vc, sender: nil)
    }
    
    private func presentAccountDelete() {
        let vm = DeleteAccountViewModel(flowController: self)
        let view = DeleteAccountView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.title = "Delete Account"
        navigationController.show(vc, sender: nil)
    }
    
    private func presentAboutApp() {
        let view = AboutAppView()
        let vc = BaseHostingController(rootView: view)
        vc.title = "About App"
        navigationController.show(vc, sender: nil)
    }
}
