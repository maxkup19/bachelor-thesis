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

final class MainFlowController: FlowController, OthersFlowControllerDelegate, StudentsFlowControllerDelegate {
    
    private let userRole: UserRoleEnum
    weak var delegate: MainFlowControllerDelegate?
    weak var taskDetailOpener: TaskDetailOpenerDelegate?
    
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
    
    func showTaskDetail(id: String) {
        switchTab(.tasks)
        taskDetailOpener?.presentTaskDetail(for: id)
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
        self.taskDetailOpener = tasksFC
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
        studentsFC.delegate = self
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
    
    @discardableResult private func switchTab(_ index: MainTab) -> FlowController? {
            guard let tabController = rootViewController as? UITabBarController,
                let tabs = tabController.viewControllers, index.rawValue < tabs.count else { return nil }
            tabController.selectedIndex = index.rawValue
            return childControllers[index.rawValue]
        }
}
