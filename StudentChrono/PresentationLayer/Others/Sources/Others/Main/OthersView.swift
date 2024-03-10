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
            Button("Delete Account", role: .destructive) {
                viewModel.onIntent(.deleteAccount)
            }
            
            Button("Sign Out") {
                viewModel.onIntent(.logout)
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
