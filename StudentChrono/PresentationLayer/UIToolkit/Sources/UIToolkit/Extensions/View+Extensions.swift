//
//  View+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import SwiftUI

@MainActor
public extension View {
    @inlinable func lifecycle(_ viewModel: BaseViewModel) -> some View {
        self
            .onAppear(perform: viewModel.onAppear)
            .onDisappear(perform: viewModel.onDisappear)
    }
}

public extension View {
    /// Redact a view with a shimmering effect aka show a skeleton
    /// - Inspiration taken from [Redacted View Modifier](https://www.avanderlee.com/swiftui/redacted-view-modifier/)
    @ViewBuilder
    func skeleton(
        _ condition: @autoclosure () -> Bool,
        duration: Double = 1.5,
        bounce: Bool = false
    ) -> some View {
        redacted(reason: condition() ? .placeholder : [])
            .shimmering(active: condition(), duration: duration, bounce: bounce)
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
