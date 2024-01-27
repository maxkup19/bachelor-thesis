//
//  UIImage+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 27.01.2024.
//

import SwiftUI
import UIKit


public extension UIImage {
    
    /// Casts UIImage to Image for  using AppTheme.Images in SwiftUI Views
    var image: Image {
        Image(uiImage: self)
    }
}
