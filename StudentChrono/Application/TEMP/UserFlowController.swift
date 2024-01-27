//
//  UserFlowController.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum UsersFlow: Flow, Equatable {
    case users(Users)
    
    enum Users: Equatable {
        case showUserDetailForId(_ userId: String)
    }
}

public final class UsersFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = UsersViewModel(flowController: self)
        return BaseHostingController(rootView: UsersView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let usersFlow = flow as? UsersFlow else { return }
        switch usersFlow {
        case .users(let usersFlow): handleUsersFlow(usersFlow)
        }
    }
}

// MARK: Users flow
extension UsersFlowController {
    func handleUsersFlow(_ flow: UsersFlow.Users) {
        switch flow {
        default: return
        }
    }

}

