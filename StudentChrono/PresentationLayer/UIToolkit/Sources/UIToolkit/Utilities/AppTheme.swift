//
//  AppTheme.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import SwiftUI
import UIKit

public enum AppTheme {
    
    /// Defines all the colors used in the app in a semantic way
    public enum Colors {
        
        public static var workingThemeColor = fallbackColor
        public static let fallbackColor = Color.gray
        
        // Primary colors
        public static func primaryColor(_ baseColor: Color = workingThemeColor) -> Color {
            baseColor
        }
        public static let onPrimaryColor = Color.white
        
        // Error colors
        public static let errorColor = Color.red
        public static let onErrorColor = Color.white
        
        // Background colors
        public static let backgroundColor = Color.white
        public static let onBackgroundColor = Color.black
        
        // Background gradient
        public static let backgroundGradient = LinearGradient(
            colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.8)],
            startPoint: .top,
            endPoint: .bottom
        )
        
        // Toast color
        public static let toastInfoColor = Color.blue
        public static let toastSuccessColor = Color.green
        public static let toastErrorColor = Color.red
        
        // Text
        public static let lightTextColor = Color.white
        
        // Navigation bar
        public static let navBarBackground = Color.gray
        public static let navBarTitle = Color.black
        
        // Tab bar
        public static let tabBarBackground = primaryColor()
        
        // Buttons
        public static let primaryButtonBackground = primaryColor()
        public static let blackButtonBackground = Color.black
        public static let primaryButtonTitle = onPrimaryColor
        public static let secondaryButtonTitle = Color.white
        
        // ProgressView
        public static let progressView = primaryColor()
        
        // Whisper
        public static let whisperBackgroundInfo = Color.gray
        public static let whisperBackgroundSuccess = Color.green
        public static let whisperBackgroundError = Color.red
        public static let whisperMessage = Color.white
        
        // Pager
        public static let pagerIndicator = Color.gray
        public static let pagerSelectedIndicator = Color.black
        
        // TextField
        public static let textFieldBorder = Color.gray.opacity(0.8)
        public static let textFieldPlaceholder = Color.gray
        public static let textFieldBackground = Color.white
        
        // Divider
        public static let divider = Color.secondary
    }
    
    /// Defines all the fonts used in the app in a semantic way
    public enum Fonts {
        
        // Text
        public static let headlineText = Font.system(size: 28.0, weight: .medium)
        
        // Text fields
        public static let textFieldText = Font.system(size: 17.0, weight: .medium)
        public static let textFieldTitle = Font.system(size: 14.0, weight: .regular)
        
        // Buttons
        public static let primaryButton = Font.system(size: 20.0, weight: .regular)
        public static let secondaryButton = Font.system(size: 20.0, weight: .regular)
        
    }
    
    /// Defines all the images used in the app in a semantic way
    public enum Images {
        
        // AppIcon
        public static let appIcon = Image(systemName: "deskclock")
        
        // TextField
        public static let eye = Image(systemName: "eye")
        public static let eyeSlash = Image(systemName: "eye.slash")
        
        // Tabs
        public static let tasksTabBar = UIImage(systemName: "checklist")
        public static let studentsTabBar = UIImage(systemName: "person.3.fill")
        public static let profileTabBar = UIImage(systemName: "person")
        public static let othersTabBar = UIImage(systemName: "ellipsis")
        
    }
    
    /// Defines dimens
    public enum Dimens {
        public static let navBarHeight: CGFloat = 50
        public static let dividerHeight: CGFloat = 1
        
        
        /**
         * Spacing of 4
         */
        public static let spaceXSmall: CGFloat = 4
        /**
         * Spacing of 8
         */
        public static let spaceSmall: CGFloat = 8
        /**
         * Spacing of 12
         */
        public static let spaceMediumSmall: CGFloat = 12
        /**
         * Spacing of 16
         */
        public static let spaceMedium: CGFloat = 16
        /**
         * Spacing of 22
         */
        public static let spaceMediumLarge: CGFloat = 22
        /**
         * Spacing of 24
         */
        public static let spaceLarge: CGFloat = 24
        /**
         * Spacing of 32
         */
        public static let spaceXLarge: CGFloat = 32
        /**
         * Spacing of 44
         */
        public static let spaceXXLarge: CGFloat = 44
        /**
         * Spacing of 64
         */
        public static let spaceXXXLarge: CGFloat = 64
        
        /**
         * Radius of 4
         */
        public static let radiusXXSmall = CGFloat(4)
        /**
         * Radius of 6
         */
        public static let radiusXSmall: CGFloat = 8
        /**
         * Radius of 12
         */
        public static let radiusSmall: CGFloat = 12
        /**
         * Radius of 15
         */
        public static let radiusMedium: CGFloat = 15
        /**
         * Radius of 20
         */
        public static let radiusLarge: CGFloat = 20
        /**
         * Radius of 32
         */
        public static let radiusXLarge: CGFloat = 36
        
    }
}
