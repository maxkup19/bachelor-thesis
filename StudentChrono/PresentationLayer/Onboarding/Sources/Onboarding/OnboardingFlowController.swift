//
//  OnboardingFlowController.swift
//  
//
//  Created by Maksym Kupchenko on 22.02.2024.
//

import SharedDomain
import SwiftUI
import UIKit
import UIToolkit

enum OnboardingFlow: Flow, Equatable {
    case onboarding(Onboarding)
    
    enum Onboarding: Equatable {
        case finishOnboarding(UserRoleEnum?)
    }
}

public protocol OnboardingFlowControllerDelegate: AnyObject {
    func finishOnboarding(userRole: UserRoleEnum?)
}

public final class OnboardingFlowController: FlowController {
    
    public weak var delegate: OnboardingFlowControllerDelegate?
    
    override public func setup() -> UIViewController {
        let vm = LaunchScreenViewModel(flowController: self)
        return BaseHostingController(rootView: LaunchScreenView(viewModel: vm), statusBarStyle: .lightContent)
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let onboardingFlow = flow as? OnboardingFlow else { return }
        switch onboardingFlow {
        case .onboarding(let onboardingFlow): handleOnboardingFlow(onboardingFlow)
        }
    }
}

// MARK: Onboarding flow
extension OnboardingFlowController {
    func handleOnboardingFlow(_ flow: OnboardingFlow.Onboarding) {
        switch flow {
        case .finishOnboarding(let userRole): delegate?.finishOnboarding(userRole: userRole)
        }
    }
}
