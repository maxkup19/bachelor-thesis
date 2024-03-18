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
        case personalInformation
        case updatePassword
        case dismissSheet
    }
}

public final class ProfileFlowController: FlowController {
    
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
    
    override public func dismiss() {
        navigationController.dismiss(animated: true)
    }
}

// MARK: - Profile Flow
extension ProfileFlowController {
    func handleFlow(_ flow: ProfileFlow.Profile) {
        switch flow {
        case .personalInformation: presentPersonalInformation()
        case .updatePassword: presentUpdatePassword()
        case .dismissSheet: dismiss()
        }
    }
    
    private func presentPersonalInformation() {
        let vm = PersonalInformationViewModel(flowController: self)
        let view = PersonalInformationView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        
        vc.title = "Personal Information"
        navigationController.show(vc, sender: nil)
    }
    
    private func presentUpdatePassword() {
        let vm = UpdatePasswordViewModel(flowController: self)
        let view = UpdatePasswordView(viewModel: vm)
        let vc = BaseHostingController(rootView: view)
        vc.modalPresentationStyle = .automatic
        
        navigationController.present(vc, animated: true)
    }
}
