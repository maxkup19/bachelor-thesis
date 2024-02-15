//
//  RegistrationView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIToolkit

struct RegistrationView: View {
    
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            PrimaryTextField(
                "Email",
                text: Binding(
                    get: { viewModel.state.email },
                    set: { email in viewModel.onIntent(.emailChanged(email))}
                )
            )
            
            PrimaryTextField(
                "Password",
                text: Binding(
                    get: { viewModel.state.password },
                    set: { password in viewModel.onIntent(.passwordChanged(password))}
                ),
                secure: true
            )
            
            PrimaryTextField(
                "Confirm Password",
                text: Binding(
                    get: { viewModel.state.confirmedPassword },
                    set: { confirmedPassword in viewModel.onIntent(.confirmedPasswordChanged(confirmedPassword))}
                ),
                secure: true
            )
            
            
            Button("Register") {
                viewModel.onIntent(.registerTap)
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
    RegistrationView(viewModel: RegistrationViewModel(flowController: nil))
}
