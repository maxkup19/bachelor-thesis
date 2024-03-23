//
//  TasksView.swift
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct TasksView: View {
    
    typealias Task = SharedDomain.Task
    
    @ObservedObject private var viewModel: TasksViewModel
    
    init(viewModel: TasksViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if !viewModel.state.isLoading && viewModel.state.tasks.isEmpty {
                ContentUnavailableView(
                    "No tasks",
                    systemImage: "list.bullet",
                    description: Text("You have no tasks available")
                )
            } else {
                TasksList(
                    tasks: viewModel.state.tasks,
                    onTaskTap: { id in viewModel.onIntent(.onTaskTap(id))},
                    onRefresh: { viewModel.onIntent(.refreshTasks) }
                )
#warning("Revisit is Future")
                //                .searchable(
                //                    text: Binding(
                //                        get: { viewModel.state.searchText },
                //                        set: { value in viewModel.onIntent(.searchTextChanged(value)) }
                //                    ),
                //                    placement: .toolbar
                //                )
            }
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                if viewModel.state.showCreateButtonTask {
                    Button(action: { viewModel.onIntent(.createTask) }) {
                        AppTheme.Images.plus
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
#warning("TODO: add filter and sorting")
                } label: {
                    AppTheme.Images.dots
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
