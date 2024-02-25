//
//  ProfileFlowController.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum ProfileFlow: Flow, Equatable {
    case profile(Profile)
    
    enum Profile: Equatable {
        case deleteAccount
    }
}

public protocol ProfileFlowControllerDelegate: AnyObject {
    func logout()
}

public final class ProfileFlowController: FlowController {
    
    public weak var delegate: ProfileFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = ProfileViewModel(flowController: self)
        return BaseHostingController(rootView: ProfileView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let profileFlow = flow as? ProfileFlow else { return }
        switch profileFlow {
        case .profile(let profile): handleFlow(profile)
        }
    }
    
}

// MARK: - Profile Flow
extension ProfileFlowController {
    func handleFlow(_ flow: ProfileFlow.Profile) {
        switch flow {
        case .deleteAccount: deleteAccount()
        }
    }
    
    private func deleteAccount() {
        delegate?.logout()
    }
}
