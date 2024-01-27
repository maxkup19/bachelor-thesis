//
//  UserViewModel.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import SwiftUI
import UIToolkit

final class UsersViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        var isLoading: Bool = false
    }
    
    // MARK: Intent
    enum Intent {
    }

    func onIntent(_ intent: Intent) {
    }
    
    // MARK: Private
    
}
