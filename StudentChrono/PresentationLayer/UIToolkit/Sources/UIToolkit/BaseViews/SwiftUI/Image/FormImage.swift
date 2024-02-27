//
//  FormImage.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SwiftUI

public struct FormImage: View {
    
    private let image: Image
    private let color: Color
    
    private let size: CGFloat = 30
    
    public init(
        image: Image,
        color: Color
    ) {
        self.image = image
        self.color = color
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: size, height: size)
            .foregroundStyle(color)
            .overlay {
                image
            }
    }
}

#if DEBUG

#Preview {
    FormImage(image: AppTheme.Images.calendar, color: .green)
}
#endif
