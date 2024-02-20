//
//  PrimaryTextField.swift
//  
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

public struct PrimaryTextField: View {
    
    private let titleKey: String
    private let titleAboveIsVisible: Bool
    private let isFocused: Bool
    private let text: Binding<String>
    
    public init(
        _ titleKey: String,
        titleAboveIsVisible: Bool = false,
        isFocused: Bool = false,
        text: Binding<String>
    ) {
        self.titleKey = titleKey
        self.titleAboveIsVisible = titleAboveIsVisible
        self.isFocused = isFocused
        self.text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            if titleAboveIsVisible {
                Text(titleKey)
                    .font(AppTheme.Fonts.textFieldTitle)
                    .foregroundColor(AppTheme.Colors.textFieldPlaceholder)
            }

            TextField("", text: text)
                .textFieldStyle(PrimaryTextFieldStyle(isFocused: isFocused))
                .placeholder(when: text.wrappedValue.isEmpty) {
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

#if DEBUG
struct PrimaryTextField_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
    }
}
#endif
