//
//  UpdatePasswordView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct UpdatePasswordView: View {
    
    @ObservedObject private var viewModel: UpdatePasswordViewModel
    
    init(viewModel: UpdatePasswordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Update password View")
        }
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
    
    let vm = UpdatePasswordViewModel(flowController: nil)
    return UpdatePasswordView(viewModel: vm)
}

#endif
