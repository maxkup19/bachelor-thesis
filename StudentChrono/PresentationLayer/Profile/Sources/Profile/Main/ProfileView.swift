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
            Text("ProfileView")
            
            #warning("TODO: Update design!")
            Button("Delete account", role: .destructive) {
                viewModel.onIntent(.showDeleteAccountDialog)
            }
        }
        .toolbar(.hidden)
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alertData },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(flowController: nil))
}
