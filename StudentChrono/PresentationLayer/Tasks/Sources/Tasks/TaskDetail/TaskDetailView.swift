//
//  TaskDetailView.swift
//
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import SwiftUI
import UIToolkit

struct TaskDetailView: View {
    
    @ObservedObject private var viewModel: TaskDetailViewModel
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("TaskDetailView")
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
    
    let vm = TaskDetailViewModel(flowController: nil, taskId: "")
    return TaskDetailView(viewModel: vm)
}
#endif
