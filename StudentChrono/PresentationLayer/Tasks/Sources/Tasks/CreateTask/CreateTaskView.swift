//
//  CreateTaskView.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

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
                    Section {
                        TextField(
                            "Title",
                            text: Binding(
                                get: { viewModel.state.title },
                                set: { value in viewModel.onIntent(.titleChanged(value)) }
                            ),
                            axis: .vertical
                        )

                        TextField(
                            "Description",
                            text: Binding(
                                get: { viewModel.state.description },
                                set: { value in viewModel.onIntent(.descriptionChanged(value)) }
                            ),
                            axis: .vertical
                        )
                        .lineLimit(4...)
                    }
                    
                    Section {
                        NavigationLink("Details") {
                            AddTaskDetailsView(viewModel: viewModel)
                        }
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("**Add**") {
                        
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
