//
//  BaseNavigationController.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import UIKit

public final class BaseNavigationController: UINavigationController {
    
    private var statusBarStyle: UIStatusBarStyle = .default
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override public var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
    public convenience init(statusBarStyle: UIStatusBarStyle) {
        self.init(nibName: nil, bundle: nil)
        self.statusBarStyle = statusBarStyle
    }
}
