//
//  MainFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import UIKit
import UIToolkit

enum MainTab: Int {
    case users
}

final class MainFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        main.viewControllers = [setupUsersTab()]
        return main
    }
    
    private func setupUsersTab() -> UINavigationController {
        let usersNC = BaseNavigationController(statusBarStyle: .lightContent)
        usersNC.tabBarItem = UITabBarItem(
            title: "Back",
            image: AppTheme.Images.usersTabBar,
            tag: MainTab.users.rawValue
        )
        let usersFC = AuthFlowController(navigationController: usersNC)
        let usersRootVC = startChildFlow(usersFC)
        usersNC.viewControllers = [usersRootVC]
        return usersNC
    }
}
