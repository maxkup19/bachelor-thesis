//
//  ChangePasswordView.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import SwiftUI
import UIToolkit

struct ChangePasswordView: View {
    
    enum Field {
        case new
        case verify
    }
    
    @Binding private var newPassword: String
    @Binding private var verifyNewPassword: String
    
    @FocusState private var focusedField: Field?
    
    
    private let textWidth: CGFloat = 50
    
    init(
        newPassword: Binding<String>,
        verifyNewPassword: Binding<String>
    ) {
        self._newPassword = newPassword
        self._verifyNewPassword = verifyNewPassword
    }
    
    var body: some View {
        Form {
            Section {
                HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                    Text("New")
                        .frame(width: textWidth, alignment: .leading)
                        
                    SecureField(
                        text: $newPassword,
                        prompt: Text("Enter Password"),
                        label: { }
                    )
                    .focused($focusedField, equals: .new)
                    .onSubmit { focusedField = .verify}
                }
                
                HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                    Text("Verify")
                        .frame(width: textWidth, alignment: .leading)
                    
                    SecureField(
                        text: $verifyNewPassword,
                        prompt: Text("Re-Enter Password"),
                        label: { }
                    )
                    .focused($focusedField, equals: .verify)
                    .onSubmit { focusedField = nil }
                }
            } footer: {
                Text("Your password should be at least 8 characters long, include a number, an uppercase letter and a lowercase letter for better security.")
            }

        }
        .navigationTitle("Change Password")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#if DEBUG

#Preview {
    ChangePasswordView(
        newPassword: .constant(""),
        verifyNewPassword: .constant("")
    )
}
#endif
