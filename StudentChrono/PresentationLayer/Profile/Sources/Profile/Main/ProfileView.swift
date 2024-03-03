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
        VStack {

            RemoteImage(
                stringURL: viewModel.state.user.imageURL,
                placeholder: Image(systemName: "person.circle.fill")
            )
            
            Text("\(viewModel.state.user.name) \(viewModel.state.user.lastName)")
            
            Button("Delete account", role: .destructive) {
                viewModel.onIntent(.showDeleteAccountDialog)
            }
        }
        .skeleton(viewModel.state.isLoading)
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
