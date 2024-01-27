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
        
        // Main colors
        public static let primaryColor = Color.yellow
        public static let secondaryColor = Color.blue
        //
        // Navigation bar
        public static let navBarBackground = Color.yellow
        public static let navBarTitle = Color.white
        //
        // Backgrounds
        public static let background = Color(UIColor.systemBackground)
        //
        // Texts
        public static let text = Color(UIColor.label)
        //        public static let headlineText = Asset.Colors.mateeYellow.color
        //
        // Text fields
        public static let textFieldTitle = Color(UIColor.systemGray)
        public static let textFieldBorder = Color(UIColor.systemGray4)
        //
        // Buttons
        //        public static let primaryButtonBackground = Asset.Colors.mateeYellow.color
        public static let primaryButtonTitle = Color.white
        public static let secondaryButtonBackground = Color.clear
        //        public static let secondaryButtonTitle = Asset.Colors.mateeYellow.color
        //
        // ProgressView
        //        public static let progressView = Asset.Colors.mateeYellow.color
        //
        //        // Whisper
        //        public static let whisperBackgroundInfo = Color.gray
        //        public static let whisperBackgroundSuccess = Color.green
        //        public static let whisperBackgroundError = Color.red
        //        public static let whisperMessage = Color.white
        //
        // Toast
        //        public static let toastSuccessColor = Asset.Colors.success.color
        //        public static let toastErrorColor = Asset.Colors.error.color
        //        public static let toastInfoColor = Asset.Colors.info.color
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
        
        // Whisper
        //        public static let whisperMessage = Font.system(size: 13.0, weight: .medium)
        //        public static let whisperMessageUIKit = UIFont.systemFont(ofSize: 13.0, weight: .medium)
    }
    
    /// Defines all the images used in the app in a semantic way
    public enum Images {
        
        // Tabs
        public static let usersTabBar = UIImage(named: "UserTabBar")
        
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
