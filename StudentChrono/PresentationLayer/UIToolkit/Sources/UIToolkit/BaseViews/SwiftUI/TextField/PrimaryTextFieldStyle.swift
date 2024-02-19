//
//  PrimaryTextFieldStyle.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

public struct PrimaryTextFieldStyle: TextFieldStyle {
    
    public enum `Type` {
        case normal
        case secure(isShowingPassword: Bool, showPasswordAction: () -> Void)
    }
    
    private let type: `Type`
    private let isFocused: Bool
    private let accentColor: Color
    private let borderColor: Color
    
    private let minHeight: CGFloat = 20
    private let eyeSize: CGFloat = 16
    
    public init(
        type: `Type` = .normal,
        isFocused: Bool = false
    ) {
        self.type = type
        self.isFocused = isFocused
        self.accentColor = isFocused ? AppTheme.Colors.onBackgroundColor : AppTheme.Colors.textFieldPlaceholder
        self.borderColor = isFocused ? AppTheme.Colors.onBackgroundColor : AppTheme.Colors.textFieldBorder
    }
    
    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            configuration
            
            switch type {
            case .secure(isShowingPassword: true, let showPasswordAction):
                setupPasswordButton(isShowingPassword: true, showPasswordAction: showPasswordAction)
            case .secure(isShowingPassword: false, let showPasswordAction):
                setupPasswordButton(isShowingPassword: false, showPasswordAction: showPasswordAction)
            default:
                EmptyView()
            }
        }
        .frame(minHeight: minHeight)
        .font(AppTheme.Fonts.textFieldText)
        .accentColor(accentColor)
        .animation(.linear(duration: 0.1), value: isFocused)
        .foregroundColor(accentColor)
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.Dimens.radiusMedium)
                .stroke(borderColor, lineWidth: 1)
        )
        .animation(.linear(duration: 0.1), value: isFocused)
    }
    
    private func setupPasswordButton(isShowingPassword: Bool, showPasswordAction: @escaping () -> Void) -> some View {
        Button(action: showPasswordAction) {
            if !isShowingPassword {
                AppTheme.Images.eyeSlash
                    .resizable()
            } else {
                AppTheme.Images.eye
                    .resizable()
            }
        }
        .scaledToFit()
        .frame(width: eyeSize, height: eyeSize)
    }
}

#if DEBUG
struct PrimaryTextFieldStyle_Previews: PreviewProvider {
    static var previews: some View {
        TextField("Lorem Ipsum", text: .constant("Lorem Ipsum"))
            .textFieldStyle(PrimaryTextFieldStyle())
    }
}
#endif
