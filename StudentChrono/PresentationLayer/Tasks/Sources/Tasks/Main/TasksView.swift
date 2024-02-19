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

#Preview {
    TasksView(viewModel: TasksViewModel(flowController: nil))
}
