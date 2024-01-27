//
//  MainFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import UIKit
import UIToolkit

enum MainTab: Int {
    case users = 0
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
            title: "vserfkv",//L10n.hello,
            image: Asset.Images.usersTabBar.uiImage,
            tag: MainTab.users.rawValue
        )
        let usersFC = UsersFlowController(navigationController: usersNC)
        let usersRootVC = startChildFlow(usersFC)
        usersNC.viewControllers = [usersRootVC]
        return usersNC
    }
}
