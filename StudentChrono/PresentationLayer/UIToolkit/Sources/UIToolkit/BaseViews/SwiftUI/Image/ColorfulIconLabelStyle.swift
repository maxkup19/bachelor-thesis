//
//  ColorfulIconLabelStyle.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI

public struct ColorfulIconLabelStyle: LabelStyle {
    
    private let color: Color
    
    public init(color: Color = .gray) {
        self.color = color
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .font(.footnote)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7).frame(width: 28, height: 28).foregroundColor(color))
        }
    }
}
