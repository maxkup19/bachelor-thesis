//
//  LaunchScreenViewModel.swift
//
//
//  Created by Maksym Kupchenko on 22.02.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit

final class LaunchScreenViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.isUserLoggedUseCase) private var isUserLoggedUseCase
    @Injected(\.getCurrentUserRoleUseCase) private var getCurrentUserRoleUseCase

    init(flowController: FlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            await loadData()
        })
    }
    
    // MARK: State
    
    @Published private(set) var state: State = State()

    struct State {
        
    }
    
    // MARK: Intent
    enum Intent {
        
    }

    func onIntent(_ intent: Intent) { }
    
    // MARK: Private
    
    private func loadData() async {
        do {
            if isUserLoggedUseCase.execute() {
                let userRole = try await getCurrentUserRoleUseCase.execute()
                flowController?.handleFlow(OnboardingFlow.onboarding(.finishOnboarding(userRole)))
            } else {
                flowController?.handleFlow(OnboardingFlow.onboarding(.finishOnboarding(nil)))
            }
        } catch {
            flowController?.handleFlow(OnboardingFlow.onboarding(.finishOnboarding(nil)))
        }
    }
}
