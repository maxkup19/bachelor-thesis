//
//  AddTaskDetailsView.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SwiftUI
import UIToolkit

struct AddTaskDetailsView: View {
    
    @ObservedObject private var viewModel: CreateTaskViewModel
    
    init(viewModel: CreateTaskViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("**Add**") {
                        
                    }
                    .disabled(viewModel.state.title.isEmpty)
                }
            }
            .navigationTitle("Details")
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
    return AddTaskDetailsView(viewModel: vm)
}
#endif
