//
//  KeychainProvider.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum KeychainCoding: String, CaseIterable {
    case userId
}

// sourcery: AutoMockable
public protocol KeychainProvider {
    
    /// Try to read a value for the given key
    func read(_ key: KeychainCoding) throws -> String

    /// Create or update the given key with a given value
    func update(_ key: KeychainCoding, value: String) throws

    /// Delete value for the given key
    func delete(_ key: KeychainCoding) throws

    /// Delete all records
    func deleteAll() throws
}
