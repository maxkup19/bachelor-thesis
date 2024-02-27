//
//  FormImage.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SwiftUI

public struct FormImage: View {
    
    public enum `Type` {
        case circle
        case rectangle
    }
    
    private let type: Type
    private let image: Image
    private let color: Color
    
    private let size: CGFloat = 30
    
    public init(
        _ type: Type,
        image: Image,
        color: Color
    ) {
        self.type = type
        self.image = image
        self.color = color
    }
    
    public var body: some View {
        Group {
            switch type {
            case .circle: Circle()
            case .rectangle: RoundedRectangle(cornerRadius: 5)
            }
        }
        .frame(width: size, height: size)
        .foregroundStyle(color)
        .overlay {
            image
        }
    }
}

#if DEBUG

#Preview {
    FormImage(.rectangle, image: AppTheme.Images.calendar, color: .green)
}
#endif
