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
    
    private let formHeight: CGFloat = 130
    private let iconSize: CGFloat = 100
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: AppTheme.Dimens.spaceXLarge) {
            
            VStack(spacing: AppTheme.Dimens.spaceMedium) {
                Text("StudentChrono")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Sign in with an email to acces your tasks")
                    .font(.subheadline)
            }
            
            AppTheme.Images.appIcon
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
            
            VStack(spacing: .zero) {
                EmailAndPasswordView(
                    email: Binding(
                        get: { viewModel.state.email },
                        set: { email in viewModel.onIntent(.changeEmail(email)) }
                    ),
                    password: Binding(
                        get: { viewModel.state.password },
                        set: { password in viewModel.onIntent(.changePassword(password)) }
                    )
                )
                .frame(height: formHeight)
                
                Button("Don't have an Account?") {
                    viewModel.onIntent(.showRegistration)
                }
            }
            
            Spacer()
            
            Button {
                viewModel.onIntent(.login)
            } label: {
                Text("Login")
                    .bold()
                    .padding(AppTheme.Dimens.spaceSmall)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(AppTheme.Dimens.spaceLarge)
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .toastView(Binding<ToastData?>(
            get: { viewModel.state.toastData },
            set: { _ in viewModel.onIntent(.dismissToast) }
        ))
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = LoginViewModel(flowController: nil)
    return LoginView(viewModel: vm)
}

#endif
