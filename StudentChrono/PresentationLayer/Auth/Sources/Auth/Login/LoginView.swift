//
//  LoginView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIToolkit

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            EmailAndPasswordView(
                email: Binding(
                    get: { viewModel.state.email },
                    set: { value in viewModel.onIntent(.changeEmail(value)) }
                ),
                password: Binding(
                    get: { viewModel.state.password },
                    set: { value in viewModel.onIntent(.changePassword(value)) }
                ),
                isShowingPassword: viewModel.state.isShowingPassword,
                onShowPasswordAction: { viewModel.onIntent(.showPasswordToggle) }
            )
            
            Button("Login") {
                viewModel.onIntent(.login)
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .toastView(Binding<ToastData?>(
            get: { viewModel.state.toastData },
            set: { _ in viewModel.onIntent(.dismissToast) }
        ))
    }
}

#Preview {
    let vm = LoginViewModel(flowController: nil)
    return LoginView(viewModel: vm)
}
