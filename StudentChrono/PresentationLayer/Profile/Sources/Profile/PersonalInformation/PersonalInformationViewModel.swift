//
//  PersonalInformationViewModel.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import DependencyInjection
import Factory
import SharedDomain
import SwiftUI
import UIToolkit
import UIKit

final class PersonalInformationViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.updateUserInfoUseCase) private var updateUserInfoUseCase
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    
    init(flowController: FlowController?) {
        self.flowController = flowController
    }
    
    // MARK: - Lifecycle
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            await loadData()
        })
    }
    
    override func onDisappear() {
        super.onDisappear()
        executeTask(Task {
            await updateUserInfo()
        })
    }
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var user: User = User.studentStub
        var showDatePicker: Bool = false
        var name: String = ""
        var lastName: String = ""
        var birthDay: Date = .now
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case nameChanged(String)
        case lastNameChanged(String)
        case birthDayChanged(Date)
        case showDatePickerTap
        case verifyUserInfo
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .nameChanged(let name): nameChanged(name)
            case .lastNameChanged(let lastName): lastNameChanged(lastName)
            case .birthDayChanged(let birthDay): birthDayChanged(birthDay)
            case .showDatePickerTap: showDatePickerTap()
            case .verifyUserInfo: verifyUserInfo()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        do {
            state.user = try await getCurrentUserUseCase.execute()
            state.name = state.user.name
            state.lastName = state.user.lastName
            state.birthDay = state.user.birthDay
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func verifyUserInfo() {
        if state.name.isEmpty {
            state.name = state.user.name
        }
        if state.lastName.isEmpty {
            state.lastName = state.user.lastName
        }
        
    }
    
    private func updateUserInfo() async {
        verifyUserInfo()
        
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            let payload = UpdateUserInfoData(
                name: state.name,
                lastName: state.lastName,
                birthDay: state.birthDay
            )
            try await updateUserInfoUseCase.execute(payload)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func nameChanged(_ name: String) {
        state.name = name
    }
    
    private func lastNameChanged(_ lastName: String) {
        state.lastName = lastName
    }
    
    private func birthDayChanged(_ birthday: Date) {
        state.birthDay = birthday
    }
    
    private func showDatePickerTap() {
        withAnimation {
            state.showDatePicker.toggle()
        }
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
