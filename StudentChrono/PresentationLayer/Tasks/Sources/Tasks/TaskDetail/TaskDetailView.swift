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
    
    let size: CGFloat = 60
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Dimens.spaceLarge) {
            
            TaskDetailHeaderView(task: viewModel.state.task)
            
            Spacer()
            
            
        }
        .padding()
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
    
    let vm = TaskDetailViewModel(taskId: "", flowController: nil)
    return TaskDetailView(viewModel: vm)
}
#endif
