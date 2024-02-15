//
//  BaseHostingController.swift
//
//
//  Created by Maksym Kupchenko on 27.01.2024.
//

import OSLog
import SwiftUI
import Utilities

public class BaseHostingController<Content>: UIHostingController<Content> where Content: View {
    
    private var statusBarStyle: UIStatusBarStyle?
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle ?? navigationController?.preferredStatusBarStyle ?? .default
    }
    
    public convenience init(rootView: Content, statusBarStyle: UIStatusBarStyle) {
        self.init(rootView: rootView)
        self.statusBarStyle = statusBarStyle
    }
    
    override public init(rootView: Content) {
        super.init(rootView: rootView)
        Logger.lifecycle.info("\(type(of: self)) initialized")
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger.lifecycle.info("\(type(of: self)) initialized")
        setupUI()
    }
    
    deinit {
        Logger.lifecycle.info("\(type(of: self)) deinitialized")
    }
    
    private func setupUI() {
        // Setup background color and back button title
        view.backgroundColor = UIColor(AppTheme.Colors.background)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
}
