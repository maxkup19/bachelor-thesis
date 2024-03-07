//
//  ProfileViewModel.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import DependencyInjection
import Factory
import PhotosUI
import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit
import UIKit

final class ProfileViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    @Injected(\.updateUserInfoUseCase) private var updateUserInfoUseCase
    @Injected(\.deleteAccountUseCase) private var deleteAccountUseCase
    
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
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var user: User = User.studentStub
        var photoPickerPresented: Bool = false
        var photoPickerItem: PhotosPickerItem?
        var updateName: String = ""
        var updateLastName: String = ""
        var updateBirthDay: Date = .now
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case showDeleteAccountDialog
        case refresh
        case deleteAccount
        case userImageTap
        case updatePasswordTap
        case verifyUserName
        case updateUserInfo
        case updateNameChanged(String)
        case updateLastNameChanged(String)
        case updateBirthDayChanged(Date)
        case photoPickerPresentedChanged(Bool)
        case photoPickerItemChanged(PhotosPickerItem?)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .showDeleteAccountDialog: showDeleteAccountDialog()
            case .refresh: await loadData()
            case .deleteAccount: await deleteAccount()
            case .userImageTap: userImageTap()
            case .updatePasswordTap: updatePasswordTap()
            case .verifyUserName: verifyUserInfo()
            case .updateUserInfo: await updateUserInfo()
            case .updateNameChanged(let name): updateNameChanged(name)
            case .updateLastNameChanged(let lastName): updateLastNameChanged(lastName)
            case .updateBirthDayChanged(let birthDay): updateBirthDayChanged(birthDay)
            case .photoPickerPresentedChanged(let changed): photoPickerPresentedChanged(changed)
            case .photoPickerItemChanged(let item): photoPickerItemChanged(item)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            state.user = try await getCurrentUserUseCase.execute()
            state.updateName = state.user.name
            state.updateLastName = state.user.lastName
            state.updateBirthDay = state.user.birthDay
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func showDeleteAccountDialog() {
        state.alertData = .init(
            title: "Delete Account",
            message: "Are you sure you want to delete your account? This will permanently erase your account.",
            primaryAction: .init(title: "Cancel", style: .cancel, handler: dismissAlert),
            secondaryAction: .init(title: "Delete", style: .destruction, handler: { self.onIntent(.deleteAccount) })
        )
    }
    
    private func deleteAccount() async {
        do {
            try await deleteAccountUseCase.execute()
            flowController?.handleFlow(ProfileFlow.profile(.deleteAccount))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func updatePasswordTap() {
        flowController?.handleFlow(ProfileFlow.profile(.updatePassword))
    }
    
    private func verifyUserInfo() {
        if state.updateName.isEmpty {
            state.updateName = state.user.name
        }
        if state.updateLastName.isEmpty {
            state.updateLastName = state.user.lastName
        }
        
    }
    
    private func updateUserInfo() async {
        verifyUserInfo()
        
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            let payload = UpdateUserInfoData(
                name: state.updateName,
                lastName: state.updateLastName,
                birthDay: state.updateBirthDay
            )
            try await updateUserInfoUseCase.execute(payload)
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func updateNameChanged(_ name: String) {
        state.updateName = name
    }
    
    private func updateLastNameChanged(_ lastName: String) {
        state.updateLastName = lastName
    }
    
    private func updateBirthDayChanged(_ birthday: Date) {
        state.updateBirthDay = birthday
    }
    
    private func photoPickerPresentedChanged(_ changed: Bool) {
        state.photoPickerPresented = changed
    }
    
    private func photoPickerItemChanged(_ item: PhotosPickerItem?) {
        if let item {
            // MARK: upload on BE
            item.loadTransferable(type: Data.self) { result in
                print(result)
            }
        }
    }
    
    private func userImageTap() {
        state.photoPickerPresented = true
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
}
