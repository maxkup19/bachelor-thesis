//
//  BaseViewController.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import OSLog
import SwiftUI
import UIKit
import Utilities

public class BaseViewController: UIViewController {
    
    // MARK: Inits
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger.lifecycle.info("\(type(of: self)) initialized")
    }
    
    deinit {
        Logger.lifecycle.info("\(type(of: self)) deinitialized")
    }
    
    // MARK: Lifecycle methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Default methods
    
    /// Override this method in a subclass and setup the view appearance
    open func setupUI() {
        // Setup background color and back button title
//        view.backgroundColor = UIColor(AppTheme.Colors.backgroundColor)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}

