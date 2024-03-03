//
//  RegistrationView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct RegistrationView: View {
    
    @ObservedObject private var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: AppTheme.Dimens.spaceMedium) {
                
                RegistrationInputView(
                    name: Binding(
                        get: { viewModel.state.name },
                        set: { name in viewModel.onIntent(.nameChanged(name)) }
                    ),
                    lastName: Binding(
                        get: { viewModel.state.lastName },
                        set: { lastName in viewModel.onIntent(.lastNameChanged(lastName)) }
                    ),
                    email: Binding(
                        get: { viewModel.state.email },
                        set: { email in viewModel.onIntent(.emailChanged(email)) }
                    ),
                    dateOfBirth: Binding(
                        get: { viewModel.state.birthDay },
                        set: { date in viewModel.onIntent(.birthDayChanged(date)) }
                    ),
                    password: Binding(
                        get: { viewModel.state.password },
                        set: { password in viewModel.onIntent(.passwordChanged(password)) }
                    ),
                    confirmedPassword: Binding(
                        get: { viewModel.state.confirmedPassword },
                        set: { confirmedPassword in viewModel.onIntent(.confirmedPasswordChanged(confirmedPassword)) }
                    )
                )
                
                if viewModel.state.showRoleSelector {
                    Picker(
                        "Role",
                        selection: Binding(
                            get: { viewModel.state.role },
                            set: { value in viewModel.onIntent(.roleChanged(value))}
                        ),
                        content: {
                            ForEach(UserRoleEnum.allCases) { val in
                                if val != .admin {
                                    Text(val.rawValue.capitalized)
                                        .tag(val)
                                }
                            }
                        }
                    )
                    .pickerStyle(.palette)
                }
                
                Button {
                    viewModel.onIntent(.registerTap)
                } label: {
                    Text("Register")
                        .bold()
                        .padding(AppTheme.Dimens.spaceSmall)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.state.buttonDisabled)
                
            }
            .navigationTitle("Registration")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
        }
        .padding([.bottom, .horizontal], AppTheme.Dimens.spaceLarge)
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
    
    let vm = RegistrationViewModel(flowController: nil)
    return RegistrationView(viewModel: vm)
}

#endif
