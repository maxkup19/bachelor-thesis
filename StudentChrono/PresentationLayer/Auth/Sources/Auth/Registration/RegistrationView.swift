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
            
            HStack {
                PrimaryTextField(
                    "Name",
                    text: Binding(
                        get: { viewModel.state.name },
                        set: { name in viewModel.onIntent(.nameChanged(name)) }
                    )
                )
                
                PrimaryTextField(
                    "Lastname",
                    text: Binding(
                        get: { viewModel.state.lastname },
                        set: { lastname in viewModel.onIntent(.lastnameChanged(lastname)) }
                    )
                )
            }
            
            EmailAndPasswordView(
                email: Binding(
                    get: { viewModel.state.email },
                    set: { value in viewModel.onIntent(.emailChanged(value)) }
                ),
                password: Binding(
                    get: { viewModel.state.password },
                    set: { value in viewModel.onIntent(.passwordChanged(value)) }
                ),
                isShowingPassword: viewModel.state.isShowingPassword,
                onShowPasswordAction: { viewModel.onIntent(.showPasswordToggle) }
            )
            
            PrimaryTextField(
                "Confirm Password",
                text: Binding(
                    get: { viewModel.state.confirmedPassword },
                    set: { confirmedPassword in viewModel.onIntent(.confirmedPasswordChanged(confirmedPassword)) }
                )
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
