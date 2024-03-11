//
//  DeleteAccountView.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import SwiftUI
import UIToolkit

struct DeleteAccountView: View {
    
    @Binding private var password: String
    private let onDelete: () -> Void
    
    init(
        password: Binding<String>,
        onDelete: @escaping () -> Void
    ) {
        self._password = password
        self.onDelete = onDelete
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
                text: $password,
                prompt: Text("Enter Your Password")
            )
            .autocorrectionDisabled()
            .submitLabel(.done)
            .textContentType(.password)
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(role: .destructive, action: onDelete) {
                Text("Delete")
                    .bold()
                    .padding(AppTheme.Dimens.spaceSmall)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(AppTheme.Dimens.spaceLarge)
        .navigationTitle("Others")
    }
}


#if DEBUG

#Preview {
    DeleteAccountView(
        password: .constant(""),
        onDelete: { }
    )
}
#endif
