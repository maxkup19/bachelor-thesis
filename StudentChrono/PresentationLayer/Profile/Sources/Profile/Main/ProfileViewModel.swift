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
    @Injected(\.uploadImageUseCase) private var uploadImageUseCase
    
    init(flowController: FlowController?) {
        super.init()
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
        case refresh
        case userImageTap
        case updatePasswordTap
        case personalInformationTap
        case photoPickerPresentedChanged(Bool)
        case photoPickerItemChanged(PhotosPickerItem?)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .refresh: await loadData()
            case .userImageTap: userImageTap()
            case .updatePasswordTap: updatePasswordTap()
            case .personalInformationTap: personalInformationTap()
            case .photoPickerPresentedChanged(let changed): photoPickerPresentedChanged(changed)
            case .photoPickerItemChanged(let item): await photoPickerItemChanged(item)
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
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func updatePasswordTap() {
        flowController?.handleFlow(ProfileFlow.profile(.updatePassword))
    }
    
    private func photoPickerPresentedChanged(_ changed: Bool) {
        state.photoPickerPresented = changed
    }
    
    private func photoPickerItemChanged(_ item: PhotosPickerItem?) async {
        guard let item else { return }
        defer { state.isLoading = false }
        
        do {
            guard let data = try await item.loadTransferable(type: Data.self) else {
                return
            }
            
            state.isLoading = true
            state.user = try await uploadImageUseCase.execute(File(
                filename: state.user.fullName,
                data: data
            ))
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func personalInformationTap() {
        flowController?.handleFlow(ProfileFlow.profile(.personalInformation))
    }
    
    private func userImageTap() {
        state.photoPickerPresented = true
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
    
}
