//
//  OthersFlowController.swift
//  
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIKit
import UIToolkit

enum OthersFlow: Flow, Equatable {
    case others(Others)
    
    enum Others: Equatable {
        case logout
    }
}

public final class OthersFlowController: FlowController {
    
    override public func setup() -> UIViewController {
        let vm = OthersViewModel(flowController: self)
        return BaseHostingController(rootView: OthersView(viewModel: vm))
    }
    
    override public func handleFlow(_ flow: Flow) {
        guard let othersFlow = flow as? OthersFlow else { return }
        switch othersFlow {
        case .others(let others): handleFlow(others)
        }
    }
    
}

// MARK: - Others Flow
extension OthersFlowController {
    func handleFlow(_ flow: OthersFlow.Others) {
        switch flow {
        case .logout: logout()
        }
    }
    
    private func logout() {
        
    }
}
