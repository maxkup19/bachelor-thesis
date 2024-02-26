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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.state.showCreateButtonTask {
                    Button(action: { viewModel.onIntent(.createTask) }) {
                        AppTheme.Images.plus
                    }
                }
            }
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
    
    let vm = TasksViewModel(flowController: nil)
    return TasksView(viewModel: vm)
}

#endif
