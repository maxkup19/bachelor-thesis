//
//  AppFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import Factory
import Onboarding
import SharedDomain
import UIKit
import UIToolkit

final class AppFlowController: FlowController, AuthFlowControllerDelegate, OnboardingFlowControllerDelegate {
    
    @Injected(\.isUserLoggedUseCase) private var isUserLoggedUseCase
    @Injected(\.getCurrentUserRoleUseCase) private var getCurrentUserRoleUseCase
    
    func start() {
        presentOnboarding()
    }
    
    func finishOnboarding(userRole: UserRoleEnum?) {
        if let userRole {
            setupMain(userRole: userRole)
        } else {
            presentAuth()
        }
    }
    
    func setupMain(userRole: UserRoleEnum) {
        let fc = MainFlowController(
            userRole: userRole,
            navigationController: navigationController
        )
        let rootVC = startChildFlow(fc)
        navigationController.viewControllers = [rootVC]
    }
    
    private func presentOnboarding() {
        let nc = BaseNavigationController()
        let fc = OnboardingFlowController(navigationController: nc)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.navigationBar.isHidden = true
        navigationController.setViewControllers([rootVC], animated: false)
    }
    
    private func presentAuth() {
        let nc = BaseNavigationController()
        let fc = AuthFlowController(navigationController: nc)
        fc.delegate = self
        let rootVC = startChildFlow(fc)
        nc.navigationBar.isHidden = true
        navigationController.setViewControllers([rootVC], animated: true)
    }
}
