//
//  StudentDetailView.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import SwiftUI
import UIToolkit

struct StudentDetailView: View {
    
    @ObservedObject private var viewModel: StudentDetailViewModel
    
    init(viewModel: StudentDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppTheme.Dimens.spaceLarge) {
            StudentDetailHeaderView(
                imageURL: viewModel.state.user.imageURL,
                fullName: viewModel.state.user.fullName,
                email: viewModel.state.user.email
            )
            
            Picker(
                "Tasks",
                selection: Binding(
                    get: { viewModel.state.pickerSelection },
                    set: { selection in viewModel.onIntent(.selectionChanged(selection)) }
                )
            ) {
                Text("Active").tag(0)
                Text("Closed").tag(1)
            }
            .pickerStyle(.segmented)
            
            if !viewModel.state.filteredTasks.isEmpty {
                TasksList(
                    tasks: viewModel.state.filteredTasks,
                    onTaskTap: { id in viewModel.onIntent(.onTaskTap(id)) }
                )
            } else {
                ContentUnavailableView(
                    viewModel.state.pickerSelection == 0 ? "No active tasks" : "No closed tasks",
                    systemImage: "list.bullet"
                )
            }
            
            Spacer()
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
import SharedDomain
import SharedDomainMocks

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = StudentDetailViewModel(studentId: User.studentStub.id, flowController: nil)
    return StudentDetailView(viewModel: vm)
}
#endif
