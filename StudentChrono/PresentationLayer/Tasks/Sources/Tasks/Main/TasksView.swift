//
//  TasksView.swift
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIToolkit

struct TasksView: View {
    
    @ObservedObject private var viewModel: TasksViewModel
    
    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Your tasks will be here")
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
    
    let vm = TasksViewModel(flowController: nil)
    return TasksView(viewModel: vm)
}

#endif
