//
//  NavigationButton.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import SwiftUI

public struct NavigationButton<T: View>:  View {
    
    private let label: () -> T
    private let action: () -> Void
    
    public init(
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> T
    ) {
        self.action = action
        self.label = label
    }
    
    public var body: some View {
        Button(action: action) {
            HStack {
                label()
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(.systemGray2))
            }
        }
    }
}

#if DEBUG

#Preview {
    NavigationButton(
        action: { },
        label: {
            Label("lalala", systemImage: "bin")
        }
    )
}
#endif
