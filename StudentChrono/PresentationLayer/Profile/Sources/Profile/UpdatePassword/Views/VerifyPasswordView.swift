//
//  VerifyPasswordView.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import SwiftUI
import UIToolkit


struct VerifyPasswordView: View {
    
    @Binding private var currentPassword: String
    
    @FocusState private var isFocused: Bool
    
    init(currentPassword: Binding<String>) {
        self._currentPassword = currentPassword
    }
    
    var body: some View {
        VStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
            VStack(spacing: AppTheme.Dimens.spaceXLarge){
                Text("Enter Your\nAccount Password")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("You can change your password after successfuly providing your current.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            
            SecureField(
                text: $currentPassword,
                prompt: Text("Current Password"),
                label: { }
            )
            .font(.title2)
            .keyboardType(.asciiCapable)
            .focused($isFocused)
            .padding(.horizontal, AppTheme.Dimens.spaceXXXLarge)
            .onAppear { isFocused = true }
            
            Spacer()
        }
        .padding()
    }
}

#if DEBUG

#Preview {
    VerifyPasswordView(currentPassword: .constant(""))
}

#endif
