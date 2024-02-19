//
//  MainFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import Others
import Profile
import SharedDomain
import Tasks
import UIKit
import UIToolkit

enum MainTab: Int {
    case tasks
    case students
    case profile
    case others
}

final class MainFlowController: FlowController {
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        setupTabBarAppearance()
        main.viewControllers = [setupTasksTab(), setupProfileTab(), setupOthersTab()]
        return main
    }
    
    private func setupTabBarAppearance() {
        // Here you can setup Tab bar appearance
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
        profileNC.viewControllers = [profileRootVC]
        return profileNC
    }
    
    private func setupOthersTab() -> UINavigationController {
        let othersNC = BaseNavigationController(statusBarStyle: .default)
        othersNC.tabBarItem = UITabBarItem(
            title: "Others",
            image: AppTheme.Images.othersTabBar,
            tag: MainTab.others.rawValue
        )
        let othersFC = OthersFlowController(navigationController: othersNC)
        let othersRootVC = startChildFlow(othersFC)
        othersNC.viewControllers = [othersRootVC]
        return othersNC
    }
}
