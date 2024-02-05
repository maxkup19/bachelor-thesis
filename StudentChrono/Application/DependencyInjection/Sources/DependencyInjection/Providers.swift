//
//  Providers.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Factory
import KeychainProvider
import NetworkProvider
import UIKit
import UserDefaultsProvider

public extension Container {
    
    var keychainProvider: Factory<KeychainProvider> { self { SystemKeychainProvider() } }
    var userDefaultsProvider: Factory<UserDefaultsProvider> { self { SystemUserDefaultsProvider() } }
    var networkProvider: Factory<NetworkProvider> { self { SystemNetworkProvider(
        readAuthToken: { try self.keychainProvider().read(.authToken) },
        delegate: UIApplication.shared.delegate as? NetworkProviderDelegate
    )}}
}
