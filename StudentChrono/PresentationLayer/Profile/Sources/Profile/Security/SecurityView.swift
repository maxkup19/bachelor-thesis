//
//  SecurityView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct SecurityView: View {
    
    @Binding private var email: String
    private let onChangePassword: () -> Void
    
    init(
        email: Binding<String>,
        onChangePassword: @escaping () -> Void
    ) {
        self._email = email
        self.onChangePassword = onChangePassword
    }
    
    var body: some View {
        Form {
            Section {
                Text(email)
            } header: {
                Text("Email")
            } footer: {
                Text("This email address can be used to sign in. It can also be used to reach you by your students and/or teachers")
            }
            
            Button(
                "Change Password",
                action: onChangePassword
            ) 

        }
        .navigationTitle("Sign-In & Security")
    }
}

#if DEBUG
import SharedDomain
import SharedDomainMocks

#Preview {
    SecurityView(
        email: .constant(User.studentStub.email),
        onChangePassword: { }
    )
}

#endif
