//
//  MainFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import Auth
import DependencyInjection
import Factory
import Others
import Profile
import SharedDomain
import Students
import Tasks
import UIKit
import UIToolkit

enum MainTab: Int {
    case tasks
    case students
    case profile
    case others
}

protocol MainFlowControllerDelegate: AnyObject {
    func presentAuth(animated: Bool, completion: (() -> Void)?)
}

final class MainFlowController: FlowController, OthersFlowControllerDelegate, ProfileFlowControllerDelegate {
    
    private let userRole: UserRoleEnum
    weak var delegate: MainFlowControllerDelegate?
    
    public init(
        userRole: UserRoleEnum,
        navigationController: UINavigationController
    ) {
        self.userRole = userRole
        super.init(navigationController: navigationController)
    }
    
    override func setup() -> UIViewController {
        let main = UITabBarController()
        setupTabBarAppearance()
        
        main.viewControllers = setupViewControllers()
        return main
    }
    
    func logout() {
        delegate?.presentAuth(animated: true, completion: { [weak self] in
            self?.navigationController.viewControllers = []
            self?.stopFlow()
        })
    }
    
    private func setupTabBarAppearance() {
        // Here you can setup Tab bar appearance
    }
    
    private func setupViewControllers() -> [UINavigationController] {
        var viewControllers = [setupTasksTab(), setupProfileTab(), setupOthersTab()]
        if userRole == .teacher {
            viewControllers.append(setupStudentsTab())
        }
        viewControllers.sort(by: { $0.tabBarItem.tag < $1.tabBarItem.tag })
        return viewControllers
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
    
    private func setupStudentsTab() -> UINavigationController {
        let studentsNC = BaseNavigationController(statusBarStyle: .default)
        studentsNC.tabBarItem = UITabBarItem(
            title: "Students",
            image: AppTheme.Images.studentsTabBar,
            tag: MainTab.students.rawValue
        )
        studentsNC.tabBarItem.selectedImage = AppTheme.Images.studentsTabBarSelected
        let studentsFC = StudentsFlowController(navigationController: studentsNC)
        let studentRootVC = startChildFlow(studentsFC)
        studentsNC.viewControllers = [studentRootVC]
        return studentsNC
    }
    
    private func setupProfileTab() -> UINavigationController {
        let profileNC = BaseNavigationController(statusBarStyle: .default)
        profileNC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: AppTheme.Images.profileTabBar,
            tag: MainTab.profile.rawValue
        )
        profileNC.tabBarItem.selectedImage = AppTheme.Images.profileTabBarSelected
        let profileFC = ProfileFlowController(navigationController: profileNC)
        profileFC.delegate = self
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
        othersFC.delegate = self
        let othersRootVC = startChildFlow(othersFC)
        othersNC.viewControllers = [othersRootVC]
        return othersNC
    }
}
