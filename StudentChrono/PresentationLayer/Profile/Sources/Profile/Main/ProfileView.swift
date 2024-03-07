//
//  ProfileView.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIToolkit

struct ProfileView: View {
    
    @ObservedObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            
            ProfileHeaderView(
                imageURL: viewModel.state.user.imageURL,
                fullName: viewModel.state.user.fullName,
                email: viewModel.state.user.email,
                onImageTap: {
                    viewModel.onIntent(.userImageTap)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemBackground))
            
            Section {
                NavigationLink {
                    PersonalInformationView(
                        name: Binding(
                            get: { viewModel.state.updateName },
                            set: { name in viewModel.onIntent(.updateNameChanged(name)) }
                        ),
                        lastName: Binding(
                            get: { viewModel.state.updateLastName },
                            set: { lastName in viewModel.onIntent(.updateLastNameChanged(lastName)) }
                        ),
                        birthDay: Binding(
                            get: { viewModel.state.updateBirthDay },
                            set: { birthDay in viewModel.onIntent(.updateBirthDayChanged(birthDay)) }
                        ),
                        updateInfo: { viewModel.onIntent(.updateUserInfo) },
                        verifyName: { viewModel.onIntent(.verifyUserName) }
                    )
                } label: {
                    Label(
                        "Personal Information",
                        systemImage: "person.text.rectangle.fill"
                    )
                    .labelStyle(ColorfulIconLabelStyle())
                }
                
                NavigationLink {
                    SecurityView(
                        email: .constant(viewModel.state.user.email),
                        onChangePassword: { viewModel.onIntent(.updatePasswordTap)}
                    )
                } label: {
                    Label(
                        "Sign-In & Security",
                        systemImage: "lock.shield"
                    )
                    .labelStyle(ColorfulIconLabelStyle())
                }
            }
            
            Button("Delete account", role: .destructive) {
                viewModel.onIntent(.showDeleteAccountDialog)
            }
        }
        .refreshable {
            viewModel.onIntent(.refresh)
        }
        .photosPicker(
            isPresented: Binding(
                get: { viewModel.state.photoPickerPresented },
                set: { changed in viewModel.onIntent(.photoPickerPresentedChanged(changed)) }
            ),
            selection: Binding(
                get: { viewModel.state.photoPickerItem },
                set: { item in viewModel.onIntent(.photoPickerItemChanged(item)) }
            )
        )
        .navigationTitle("Profile")
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
    
    let vm = ProfileViewModel(flowController: nil)
    return ProfileView(viewModel: vm)
}

#endif
