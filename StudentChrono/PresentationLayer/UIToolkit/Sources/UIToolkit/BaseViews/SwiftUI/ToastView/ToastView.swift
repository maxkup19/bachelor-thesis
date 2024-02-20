//
//  ToastView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

struct ToastView: View {
    
    private let data: ToastData
    
    init(_ data: ToastData) {
        self.data = data
    }
    
    var body: some View {
        VStack {
            HStack {
                data.style.image
                    .foregroundColor(data.style.color)
                
                Text(data.title)
                    .foregroundColor(AppTheme.Colors.onBackgroundColor)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
        }
        .background(
            Capsule()
                .fill(.white)
                .clipped()
                .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

#Preview {
    Group {
        ToastView(ToastData("Info", style: .info, hideAfter: 1))
        ToastView(ToastData("Success", style: .success, hideAfter: 1))
        ToastView(ToastData("Error", style: .error, hideAfter: 1))
    }
}
