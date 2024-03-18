//
//  AboutAppView.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import SwiftUI
import UIToolkit
import Utilities

struct AboutAppView: View {
    var body: some View {
        VStack(spacing: AppTheme.Dimens.spaceLarge) {
            Spacer()
            
            AppTheme.Images.appIcon
                .resizable()
                .frame(width: 120, height: 120)
            
            Text(Bundle.app.displayName)
                .font(.title)
            
            Text("Version \(Bundle.app.version) (\(Bundle.app.build))")
                .font(.caption)
                .foregroundStyle(Color.secondary)
            
            Spacer()
            
            Text("Created by Maksym Kupchenko")
                .font(.footnote)
                .foregroundStyle(Color.secondary)
                .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG

#Preview {
    AboutAppView()
}
#endif
