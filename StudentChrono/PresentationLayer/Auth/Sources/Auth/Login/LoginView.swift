//
//  LoginView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIToolkit

struct LoginView: View {
    
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button("lalalal") {
                viewModel.onIntent(.showRegistration)
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
    }
}

#Preview {
    
    let vm = LoginViewModel(flowController: nil)
    return LoginView(viewModel: vm)
}
