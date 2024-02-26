//
//  BottomSheetView.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import SwiftUI

public struct BottomSheetView<Content: View>: View {
    
    @State private var translation: CGFloat = 0
    private let capsuleWidth: CGFloat = 48
    private let capsuleHeight: CGFloat = 4
    
    private let content: Content
    private let dismissOnPull: Bool
    private let dismiss: (() -> Void)?
    private let percentageHeight: CGFloat?
    
    public init(
        dismissOnPull: Bool = true,
        percentageHeight: Int? = nil,
        dismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.dismissOnPull = dismissOnPull
        self.dismiss = dismiss
        self.content = content()
        
        if let percentageHeight = percentageHeight {
            self.percentageHeight = CGFloat(percentageHeight) / CGFloat(100)
        } else {
            self.percentageHeight = nil
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(uiColor: UIColor.systemBackground).opacity(0.0001) // This is the minimum of the opacity that can consume tap on it
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onTapGesture {
                        dismiss?()
                    }
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .fill(Color.primary)
                            .frame(width: capsuleWidth, height: capsuleHeight)
                            .padding(AppTheme.Dimens.spaceSmall)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        content
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: UIColor.systemBackground))
                    .cornerRadius(AppTheme.Dimens.radiusMedium, corners: [.topLeft, .topRight])
                    .frame(
                        height: percentageHeight != nil
                        ? geometry.size.height * percentageHeight!
                        : geometry.size.height,
                        alignment: .bottom
                    )
                    .offset(y: max(translation, 0))
                    .shadow(color: Color.primary.opacity(0.1), radius: 10, y: -7)
                    .animation(.interactiveSpring(), value: translation)
                    .gesture(
                        DragGesture(minimumDistance: 20)
                            .onChanged { value in
                                translation = value.translation.height
                            }
                            .onEnded { value in
                                guard value.translation.height > 0 else {
                                    translation = 0
                                    return
                                }
                                
                                var offset = geometry.size.height - value.location.y
                                
                                if let percentageHeight = percentageHeight {
                                    offset = percentageHeight * geometry.size.height - value.location.y
                                }
                                
                                if dismissOnPull && offset < (percentageHeight ?? 1) * geometry.size.height * 0.7 {
                                    dismiss?()
                                } else {
                                    translation = 0
                                }
                            }
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}

#if DEBUG
struct BottomSheetView_Previews: PreviewProvider {
    
    static var previews: some View {
        BottomSheetView {
            VStack {
                ForEach(0..<5, id: \.self) { _ in
                    Text("Lorem ipsum")
                        .padding()
                }
            }
        }
    }
}
#endif
