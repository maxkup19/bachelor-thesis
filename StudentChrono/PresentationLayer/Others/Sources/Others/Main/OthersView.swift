//
//  OthersView.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIToolkit

struct OthersView: View {
    
    @ObservedObject private var viewModel: OthersViewModel
    
    init(viewModel: OthersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label(
                        "About App",
                        systemImage: "questionmark.circle"
                    )
                    .labelStyle(ColorfulIconLabelStyle(color: .accentColor))
                }
                
                NavigationLink {
                    EmptyView()
                } label: {
                    Label(
                        "Feedback",
                        systemImage: "envelope"
                    )
                    .labelStyle(ColorfulIconLabelStyle(color: .purple))
                }
            }

            Section {
                NavigationLink {
                    DeleteAccountView(
                        password: Binding(
                            get: { viewModel.state.password },
                            set: { password in viewModel.onIntent(.passwordChanged(password)) }
                        ),
                        onDelete: { viewModel.onIntent(.showDeleteAccountDialog) }
                    )
                    .alert(item: Binding<AlertData?>(
                        get: { viewModel.state.alertData },
                        set: { _ in viewModel.onIntent(.dismissAlert) }
                    )) { alert in .init(alert) }
                    
                } label: {
                    Label(
                        "Delete Account",
                        systemImage: "person.crop.circle.badge.xmark"
                    )
                    .labelStyle(ColorfulIconLabelStyle(color: .red))
                    .foregroundStyle(Color.red)
                }
            }
            
            Section {
                Button {
                    viewModel.onIntent(.logout)
                } label: {
                    Text("Sign Out")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationTitle("Others")
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
    
    let vm = OthersViewModel(flowController: nil)
    return OthersView(viewModel: vm)
}

#endif
