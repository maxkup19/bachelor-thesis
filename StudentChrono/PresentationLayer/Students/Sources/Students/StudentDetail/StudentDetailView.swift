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
    
    private let size: CGFloat = 80
    
    init(viewModel: StudentDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: AppTheme.Dimens.spaceMedium) {
                AsyncImage(url: URL(string: viewModel.state.user.imageURL ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if phase.error == nil {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                    }
                }
                .frame(width: size, height: size)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(viewModel.state.user.fullName)
                        .font(.title2)
                        .foregroundStyle(Color.primary)
                    
                    Text(viewModel.state.user.email)
                        .font(.headline)
                        .foregroundStyle(Color.secondary)
                }
                
                Spacer()
            }
            
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
import SharedDomain
import SharedDomainMocks

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = StudentDetailViewModel(studentId: User.studentStub.id, flowController: nil)
    return StudentDetailView(viewModel: vm)
}
#endif
