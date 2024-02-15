//
//  PrimaryTextFieldStyle.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

struct PrimaryTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(AppTheme.Fonts.textFieldText)
            .accentColor(AppTheme.Colors.primaryColor)
            .disableAutocorrection(true)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppTheme.Colors.textFieldBorder, lineWidth: 2)
            )
    }
}

#if DEBUG
#Preview {
    TextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
        .textFieldStyle(PrimaryTextFieldStyle())
}
#endif
