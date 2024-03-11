//
//  ScreenshotSection.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import SwiftUI
import UIToolkit

struct ScreenshotSection: View {
    
    private let showAddButton: Bool
    private let image: Image?
    private let onAddTap: () -> Void
    private let onRemoveTap: () -> Void
    
    
    init(
        showAddButton: Bool,
        image: Image?,
        onAddTap: @escaping () -> Void,
        onRemoveTap: @escaping () -> Void
    ) {
        self.showAddButton = showAddButton
        self.image = image
        self.onAddTap = onAddTap
        self.onRemoveTap = onRemoveTap
    }
    
    var body: some View {
        Section("Screenshot (optional)") {
            VStack {
                HStack {
                    Text("Screenshot")
                    
                    Spacer()
                    
                    if showAddButton {
                        Button("Add", action: onAddTap)
                            .padding(.horizontal, AppTheme.Dimens.spaceSmall)
                            .padding(.vertical, AppTheme.Dimens.spaceXSmall)
                            .background(Color.accentColor.opacity(0.4))
                            .clipShape(Capsule())
                    } else {
                        Button("Remove", action: onRemoveTap)
                            .padding(.horizontal, AppTheme.Dimens.spaceSmall)
                            .padding(.vertical, AppTheme.Dimens.spaceXSmall)
                            .foregroundStyle(Color.red)
                            .background(Color.red.opacity(0.4))
                            .clipShape(Capsule())
                    }
                }
                
                if let image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
        }
    }
}

#if DEBUG

#Preview {
    ScreenshotSection(
        showAddButton: true,
        image: nil,
        onAddTap: { },
        onRemoveTap: { }
    )
}
#endif
