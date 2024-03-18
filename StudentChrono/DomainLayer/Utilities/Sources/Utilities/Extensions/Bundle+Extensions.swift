//
//  Bundle+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import Foundation

public extension Bundle {
    var displayName: String {
        return object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    }
    
    var version: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    var build: String {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
    }
}
