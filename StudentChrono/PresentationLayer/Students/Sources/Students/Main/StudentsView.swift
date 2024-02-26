//
//  StudentsView.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SwiftUI
import UIToolkit

struct StudentsView: View {
    
    @ObservedObject private var viewModel: StudentsViewModel
    
    init(viewModel: StudentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("StudentsView")
        }
        .toolbar(.hidden)
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
    
    let vm = StudentsViewModel(flowController: nil)
    return StudentsView(viewModel: vm)
}

#endif
