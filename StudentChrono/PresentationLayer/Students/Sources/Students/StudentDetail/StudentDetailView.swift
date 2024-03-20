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
        VStack {
            Text(viewModel.state.user.fullName)
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
