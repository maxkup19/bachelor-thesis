//
//  AppDelegate.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import DependencyInjection
import Factory
import FirebaseCore
import KeychainProvider
import NetworkProvider
import OSLog
import UIKit
import UIToolkit
import UserDefaultsProvider
import Utilities

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var flowController: AppFlowController?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Clear keychain on first run
        clearKeychain()
        
        // Setup Cache capacity
        setupCacheCapacity()
        
        FirebaseApp.configure()
        
        // Init main window with navigation controller
        let nc = BaseNavigationController()
        nc.navigationBar.isHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        // Init main flow controller and start the flow
        flowController = AppFlowController(navigationController: nc)
        flowController?.start()
        
        return true
    }
    
    
    // MARK: Clear keychain
    private func clearKeychain() {
        do {
            let _: Bool = try Container.shared.userDefaultsProvider().read(.hasRunBefore)
        } catch UserDefaultsProviderError.valueForKeyNotFound {
            do {
                try Container.shared.keychainProvider().deleteAll()
                try Container.shared.userDefaultsProvider().update(.hasRunBefore, value: true)
            } catch {}
        } catch {}
    }
    
    // MARK: Cache setup
    private func setupCacheCapacity() {
        URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
        URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // Show system notification
        completionHandler([.list, .banner, .badge, .sound])
    }
}


extension AppDelegate: NetworkProviderDelegate {
    func didReceiveHttpUnauthorized() {
        Logger.app.log("DID RECEIVE 404")
//        self.flowController?.handleLogout()
    }
}
