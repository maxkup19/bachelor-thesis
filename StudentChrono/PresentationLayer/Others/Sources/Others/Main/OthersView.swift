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
        VStack {
            Text("OthersView")
            Button("Logout") {
                viewModel.onIntent(.logout)
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

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = OthersViewModel(flowController: nil)
    return OthersView(viewModel: vm)
}

#endif
