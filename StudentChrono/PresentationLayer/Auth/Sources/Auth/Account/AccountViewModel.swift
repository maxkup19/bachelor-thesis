//
//  AccountViewModel.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import Utilities

final class AccountViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    // MARK: - Depependencies
    
    private weak var flowController: AuthFlowController?
    
    init(flowController: AuthFlowController?) {
        self.flowController = flowController
        super.init()
    }
    
    // MARK: - Lifecycle
    
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            
        })
    }
    
    
    // MARK: - State
    
    @Published private(set) var state: State = State()
    
    struct State {
        var name: String = ""
        var isLoading: Bool = false
        var toastData: ToastData?
        var isShowingWarningColor: Bool = false
    }
    
    // MARK: - Intent
    
    enum Intent {
        case nameChanged(String)
        case registerTap
        case toastDataChanged(ToastData?)
        case back
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .nameChanged(let name): nameChanged(name)
            case .registerTap: await registerTap()
            case .toastDataChanged(let toastData): toastDataChanged(toastData)
            case .back: back()
            }
        })
    }
    
    // MARK: - Private
    
    private func nameChanged(_ name: String) {
        state.name = name
    }
    
    private func registerTap() async {
        
    }
    
    private func toastDataChanged(_ toastData: ToastData?) {
        state.toastData = toastData
    }
    
    private func back() {
        flowController?.pop()
    }
}
