//
//  StudentsView.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SwiftUI
import UIToolkit

struct StudentsView: View {
    
    @ObservedObject private var viewModel: StudentsViewModel
    
    init(viewModel: StudentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("StudentsView")
        }
        .toolbar(.hidden)
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
    
    let vm = StudentsViewModel(flowController: nil)
    return StudentsView(viewModel: vm)
}

#endif
