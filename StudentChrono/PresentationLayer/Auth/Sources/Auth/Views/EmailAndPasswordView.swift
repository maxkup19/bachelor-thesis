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
    
    @FocusState private var focusedField: Field?
    
    @State private var isKeyboardVisible = false
    @State private var shouldKeyboardOpen: Bool = false
    
    init(
        email: Binding<String>,
        password: Binding<String>
    ) {
        self._email = email
        self._password = password
    }
    
    var body: some View {
        Form {
            
            TextField(
                "Email",
                text: $email,
                prompt: Text("Email")
            )
            .focused($focusedField, equals: .email)
            .submitLabel(.next)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .onSubmit {
                focusedField = .password
            }
            
            SecureField(
                "Password",
                text: $password,
                prompt: Text("Password")
            )
            .focused($focusedField, equals: .password)
            .autocorrectionDisabled()
            .submitLabel(.done)
            .textContentType(.password)
            .onSubmit {
                focusedField = nil
            }
            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                if shouldKeyboardOpen {
                    focusedField = .password
                    shouldKeyboardOpen = false
                }
                isKeyboardVisible = newIsKeyboardVisible
            }
        }
        .autocorrectionDisabled()
    }
}

#if DEBUG
struct EmailAndPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EmailAndPasswordView(email: .constant(""), password: .constant("bhjh"))
    }
}
#endif

