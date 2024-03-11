//
//  ColorfulIconLabelStyle.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI

public struct ColorfulIconLabelStyle: LabelStyle {
    
    private let iconColor: Color
    private let textColor: Color
    
    public init(
        iconColor: Color = .gray,
        textColor: Color = .primary
    ) {
        self.iconColor = iconColor
        self.textColor = textColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
                .foregroundStyle(textColor)
        } icon: {
            configuration.icon
                .font(.footnote)
                .foregroundColor(.white)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .frame(width: 28, height: 28)
                        .foregroundStyle(iconColor)
                )
        }
    }
}
