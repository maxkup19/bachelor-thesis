//
//  AppFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import Factory
import Onboarding
import Others
import SharedDomain
import UIKit
import UIToolkit

final class AppFlowController: FlowController, MainFlowControllerDelegate, AuthFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    func start() {
        presentOnboarding()
    }
    
    func finishOnboarding(userRole: UserRoleEnum?) {
        if let userRole {
            setupMain(userRole: userRole)
        } else {
            presentAuth(animated: false, completion: nil)
        }
    }
    
    func setupMain(userRole: UserRoleEnum) {
        let fc = MainFlowController(
            userRole: userRole,
            navigationController: navigationController
        )
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.viewControllers = [rootVC]
    }
    
    func presentAuth(animated: Bool, completion: (() -> Void)?) {
        let nc = BaseNavigationController()
        let fc = AuthFlowController(navigationController: nc)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.viewControllers = [rootVC]
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        navigationController.present(nc, animated: animated, completion: completion)
    }
    
    private func presentOnboarding() {
        let fc = OnboardingFlowController(navigationController: navigationController)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        navigationController.navigationBar.isHidden = true
        navigationController.setViewControllers([rootVC], animated: true)
    }
}
