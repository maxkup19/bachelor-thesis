//
//  SecureTextField.swift
//
//
//  Created by Maksym Kupchenko on 19.02.2024.
//

import Foundation
import SwiftUI

public struct SecureTextField: View {
    
    private let titleKey: String
    private let showingPassword: Bool
    private let titleAboveIsVisible: Bool
    private let isFocused: Bool
    @Binding private var text: String
    
    public init(
        _ titleKey: String,
        showingPassword: Bool,
        titleAboveIsVisible: Bool = false,
        isFocused: Bool = false,
        text: Binding<String>
    ) {
        self.titleKey = titleKey
        self.showingPassword = showingPassword
        self.titleAboveIsVisible = titleAboveIsVisible
        self.isFocused = isFocused
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if titleAboveIsVisible {
                Text(titleKey)
                    .font(AppTheme.Fonts.textFieldTitle)
                    .foregroundColor(AppTheme.Colors.textFieldPlaceholder)
            }
            
            if showingPassword {
                TextField("", text: $text)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.asciiCapable)
                    .placeholder(when: text.isEmpty) {
                        Text(titleKey)
                            .font(AppTheme.Fonts.textFieldText)
                            .foregroundColor(AppTheme.Colors.textFieldPlaceholder)
                            .padding()
                    }
                    .background(AppTheme.Colors.textFieldBackground)
                    .cornerRadius(AppTheme.Dimens.radiusMedium)
                
            } else {
                SecureField("", text: $text)
                    .frame(maxWidth: .infinity)
                    .keyboardType(.asciiCapable)
                    .placeholder(when: text.isEmpty) {
                        Text(titleKey)
                            .font(AppTheme.Fonts.textFieldText)
                            .foregroundColor(AppTheme.Colors.textFieldPlaceholder)
                            .padding()
                    }
                    .background(AppTheme.Colors.textFieldBackground)
                    .cornerRadius(AppTheme.Dimens.radiusMedium)
            }
        }
    }
}

#if DEBUG
struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextField("", showingPassword: false, text: .constant(""))
    }
}
#endif

