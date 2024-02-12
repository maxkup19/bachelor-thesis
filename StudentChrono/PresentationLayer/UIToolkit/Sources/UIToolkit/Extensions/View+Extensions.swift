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
}

public extension View {
    func toastView(_ toastData: Binding<ToastData?>) -> some View {
        modifier(ToastViewModifier(toastData: toastData))
    }
}
