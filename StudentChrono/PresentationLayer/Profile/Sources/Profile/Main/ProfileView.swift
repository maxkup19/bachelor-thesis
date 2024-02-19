//
//  ProfileView.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIToolkit

struct ProfileView: View {
    
    @ObservedObject private var viewModel: ProfileViewNodel
    
    init(viewModel: ProfileViewNodel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("ProfileView")
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
    ProfileView(viewModel: ProfileViewModel(flowController: nil))
}
