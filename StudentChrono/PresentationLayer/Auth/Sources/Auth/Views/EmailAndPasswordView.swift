//
//  EmailAndPasswordView.swift
//  
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import SwiftUI
import UIToolkit

struct EmailAndPasswordView: View, KeyboardReadable {
    enum Field: Hashable {
        case email
        case password
    }
    
    @Binding private var email: String
    @Binding private var password: String
    private let isShowingPassword: Bool
    private let onShowPasswordAction: () -> Void
    
    @FocusState private var focusedField: Field?
    
    @State private var isKeyboardVisible = false
    @State private var shouldKeyboardOpen: Bool = false
    
    init(
        email: Binding<String>,
        password: Binding<String>,
        isShowingPassword: Bool,
        onShowPasswordAction: @escaping () -> Void = {}
    ) {
        self._email = email
        self._password = password
        self.isShowingPassword = isShowingPassword
        self.onShowPasswordAction = onShowPasswordAction
    }
    
    var body: some View {
        VStack(spacing: AppTheme.Dimens.spaceLarge) {
            PrimaryTextField(
                "EMAIL",
                isFocused: focusedField == .email,
                text: $email
            )
            .focused($focusedField, equals: .email)
            .submitLabel(.next)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .onSubmit {
                focusedField = .password
            }
            
            SecureTextField(
                "Password",
                showingPassword: isShowingPassword,
                text: $password
            )
            .focused($focusedField, equals: .password)
            .submitLabel(.done)
            .textContentType(.password)
            .onSubmit {
                focusedField = nil
            }
            .textFieldStyle(
                PrimaryTextFieldStyle(
                    type: .secure(
                        isShowingPassword: isShowingPassword,
                        showPasswordAction: {
                            if isKeyboardVisible {
                                shouldKeyboardOpen = true
                            }
                            onShowPasswordAction()
                        }
                    ),
                    isFocused: focusedField == .password
                )
            )
            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                if shouldKeyboardOpen {
                    focusedField = .password
                    shouldKeyboardOpen = false
                }
                isKeyboardVisible = newIsKeyboardVisible
            }
        }
        .autocorrectionDisabled(true)
        .padding(.top, AppTheme.Dimens.spaceXLarge)
    }
}

#if DEBUG
struct EmailAndPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAndPasswordView(email: .constant(""), password: .constant("bhjh"), isShowingPassword: true)
    }
}
#endif

