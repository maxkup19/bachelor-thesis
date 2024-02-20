//
//  AppFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import Factory
import UIKit
import UIToolkit

final class AppFlowController: FlowController, AuthFlowControllerDelegate {
    
    @Injected(\.isUserLoggedUseCase) private var isUserLoggedUseCase
    
    func start() {
        setupAppearance()
        
        if isUserLoggedUseCase.execute() {
            setupMain()
        } else {
            presentAuth(animated: false, completion: nil)
        }
    }
    
    func setupMain() {
        let fc = MainFlowController(navigationController: navigationController)
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
    
    private func setupAppearance() {
        // Navigation bar
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(AppTheme.Colors.navBarBackground)
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(AppTheme.Colors.navBarTitle)]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor(AppTheme.Colors.navBarTitle)
        
        // Tab bar
        UITabBar.appearance().tintColor = UIColor(AppTheme.Colors.primaryColor())
        
        // UITextField
        UITextField.appearance().tintColor = UIColor(AppTheme.Colors.primaryColor())
    }
}
