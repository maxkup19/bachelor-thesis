//
//  MainFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import Profile
import Tasks
import UIKit
import UIToolkit

enum MainTab: Int {
    case tasks
    case profile
    case others
}

final class MainFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        main.viewControllers = []
        return main
    }
    
    private func setupTasksTab() -> UINavigationController {
        let tasksNC = BaseNavigationController(statusBarStyle: .default)
        tasksNC.tabBarItem = UITabBarItem(
            title: "Tasks",
            image: AppTheme.Images.tasksTabBar,
            tag: MainTab.tasks.rawValue
        )
        let tasksFC = TasksFlowController(navigationController: tasksNC)
        let tasksRootVC = startChildFlow(tasksFC)
        tasksNC.viewControllers = [tasksRootVC]
        return tasksNC
    }
    
    private func setupProfileTab() -> UINavigationController {
        let profileNC = BaseNavigationController(statusBarStyle: .default)
        profileNC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: AppTheme.Images.profileTabBar,
            tag: MainTab.profile.rawValue
        )
        let profileFC = ProfileFlowController(navigationController: profileNC)
        let profileRootVC = startChildFlow(profileFC)
        profileFC.viewControllers = [profileRootVC]
        return profileNC
    }
}
