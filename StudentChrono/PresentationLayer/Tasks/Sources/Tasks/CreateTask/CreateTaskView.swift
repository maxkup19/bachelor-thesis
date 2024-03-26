//
//  CreateTaskView.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit

struct CreateTaskView: View {
    
    @ObservedObject private var viewModel: CreateTaskViewModel
    
    init(viewModel: CreateTaskViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    
                    TitleAndDescriptionSection(
                        title: Binding(
                            get: { viewModel.state.title },
                            set: { value in viewModel.onIntent(.titleChanged(value)) }
                        ),
                        description: Binding(
                            get: { viewModel.state.description },
                            set: { value in viewModel.onIntent(.descriptionChanged(value)) }
                        )
                    )
                    
                    Section {
                        NavigationLink("Details") {
                            AddTaskDetailsView(
                                taskDetails: Binding(
                                    get: { viewModel.state.taskDetails },
                                    set: { value in viewModel.onIntent(.taskDetailsChanged(value)) }
                                ),
                                addButtonDisabled: viewModel.state.title.isEmpty,
                                onAddButtonTap: { viewModel.onIntent(.createTask) }
                            )
                        }
                    }
                    
                    Section {
                        NavigationLink {
                            StudentSelectionList(
                                assignee: Binding(
                                    get: { viewModel.state.selectedStudentIds },
                                    set: { studentIds in viewModel.onIntent(.selectedStudentIdsChanged(studentIds)) }
                                ),
                                users: viewModel.state.students
                            )
                        } label: {
                            HStack {
                                FormImage(
                                    .circle,
                                    image: AppTheme.Images.list,
                                    color: .red
                                )
                                
                                Text("Student")
                                
                                Spacer()
                                
                                Text(viewModel.state.selectedStudentFullName)
                                    .lineLimit(1)
                                    .foregroundStyle(Color.secondary)
                            }
                        }
                    }
                    
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.onIntent(.cancelTap)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("**Add**") {
                        viewModel.onIntent(.addButtonTap)
                    }
                    .disabled(viewModel.state.title.isEmpty)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
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
    
    let vm = CreateTaskViewModel(flowController: nil)
    return CreateTaskView(viewModel: vm)
}

#endif
