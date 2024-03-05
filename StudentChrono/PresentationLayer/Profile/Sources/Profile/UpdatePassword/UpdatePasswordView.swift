//
//  UpdatePasswordView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct UpdatePasswordView: View {
    
    @ObservedObject private var viewModel: UpdatePasswordViewModel
    
    init(viewModel: UpdatePasswordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack  {
            ZStack {
                
                if viewModel.state.isLoading {
                    ProgressView(viewModel.state.viewState.progressViewTitle)
                        .padding(.top, 200)
                        .zIndex(1)
                }
                
                switch viewModel.state.viewState {
                case .verify: VerifyPasswordView(
                    currentPassword: Binding(
                        get: { viewModel.state.currentPassword },
                        set: { currentPassword in viewModel.onIntent(.currentPasswordChanged(currentPassword)) }
                    ),
                    onSubmit: { viewModel.onIntent(.currentPasswordSubmit) }
                )
                case .change: ChangePasswordView(
                    newPassword: Binding(
                        get: { viewModel.state.newPassword },
                        set: { newPassword in viewModel.onIntent(.newPasswordChanged(newPassword)) }
                    ),
                    verifyNewPassword: Binding(
                        get: { viewModel.state.verifyNewPassword },
                        set: { verifyNewPassword in viewModel.onIntent(.verifyNewPasswordChanged(verifyNewPassword)) }
                    )
                )
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.onIntent(.cancelTap)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(viewModel.state.viewState.toolbarButtonTitle) {
                        switch viewModel.state.viewState {
                        case .verify: viewModel.onIntent(.currentPasswordSubmit)
                        case .change: viewModel.onIntent(.changePassword)
                        }
                    }
                    
                }
                
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alertData },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = UpdatePasswordViewModel(flowController: nil)
    return UpdatePasswordView(viewModel: vm)
}

#endif
