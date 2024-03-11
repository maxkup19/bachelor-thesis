//
//  DeleteAccountView.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import SwiftUI
import UIToolkit

struct DeleteAccountView: View {
    
    @ObservedObject private var viewModel: DeleteAccountViewModel
    
    init(viewModel: DeleteAccountViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
            VStack(spacing: AppTheme.Dimens.spaceMedium) {
                Text("Delete Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Do you really want to delete this account? You will lose all your data and task history")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            SecureField(
                "Password",
                text: Binding(
                    get: { viewModel.state.password },
                    set: { password in viewModel.onIntent(.passwordChanged(password)) }
                ),
                prompt: Text("Enter Your Password")
            )
            .autocorrectionDisabled()
            .submitLabel(.done)
            .textContentType(.password)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(role: .destructive, action: { viewModel.onIntent(.showDeleteAccountDialog) }) {
                Text("Delete")
                    .bold()
                    .padding(AppTheme.Dimens.spaceSmall)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(AppTheme.Dimens.spaceLarge)
        .lifecycle(viewModel)
        .environment(\.isLoading, viewModel.state.isLoading)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alertData },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
    }
}


#if DEBUG
import Factory
import DependencyInjectionMocks

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = DeleteAccountViewModel(flowController: nil)
    return DeleteAccountView(viewModel: vm)
}
#endif
