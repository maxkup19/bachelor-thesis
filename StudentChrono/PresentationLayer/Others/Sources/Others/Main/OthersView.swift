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
                NavigationButton(action: { viewModel.onIntent(.aboutAppTap) }) {
                    Label(
                        "About App",
                        systemImage: "questionmark.circle"
                    )
                    .labelStyle(ColorfulIconLabelStyle(iconColor: .accentColor))
                }
                
                NavigationButton(action: { viewModel.onIntent(.feedbackTap) }) {
                    Label(
                        "Feedback",
                        systemImage: "envelope"
                    )
                    .labelStyle(ColorfulIconLabelStyle(iconColor: .purple))
                }
            }
            
            Section {
                NavigationButton(action: { viewModel.onIntent(.deleteAccountTap) }) {
                    Label(
                        "Delete Account",
                        systemImage: "person.crop.circle.badge.xmark"
                    )
                    .labelStyle(ColorfulIconLabelStyle(iconColor: .red, textColor: .red))
                }
            }
            
            Section {
                Button(action: { viewModel.onIntent(.logout) }) {
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
