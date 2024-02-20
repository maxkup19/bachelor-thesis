//
//  ToastData.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

public struct ToastData: Equatable {
    let style: ToastStyle
    let title: String
    let hideAfter: TimeInterval
    
    public init(_ title: String, style: ToastStyle = .info, hideAfter: TimeInterval = 0.0) {
        self.title = title
        self.style = style
        self.hideAfter = hideAfter
    }
    
    public init(error: String, style: ToastStyle = .error, hideAfter: TimeInterval = 2.5) {
        self.title = error
        self.style = style
        self.hideAfter = hideAfter
    }
    
    public static func == (lhs: ToastData, rhs: ToastData) -> Bool {
        lhs.title == rhs.title &&
        lhs.style == rhs.style &&
        lhs.hideAfter == rhs.hideAfter
    }
}

public enum ToastStyle {
    case info, success, error
    
    var color: Color {
        switch self {
        case .info: return AppTheme.Colors.toastInfoColor
        case .success: return AppTheme.Colors.toastSuccessColor
        case .error: return AppTheme.Colors.toastErrorColor
        }
    }
    
    var image: Image {
        switch self {
        case .info: return Image(systemName: "info.circle")
        case .success: return Image(systemName: "checkmark.circle")
        case .error: return Image(systemName: "xmark.circle")
        }
    }
}