//
//  Providers.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Factory
import KeychainProvider
import UserDefaultsProvider

public extension Container {
    
    var keychainProvider: Factory<KeychainProvider> { self { SystemKeychainProvider() } }
    var userDefaultsProvider: Factory<UserDefaultsProvider> { self { SystemUserDefaultsProvider() } }
    
}
