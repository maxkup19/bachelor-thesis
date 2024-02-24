//
//  Data+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public extension Data {
    func map<D: Decodable>(_ type: D.Type, atKeyPath keyPath: String? = nil) throws -> D {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        if let keyPath {
            let toplevel = try JSONSerialization.jsonObject(with: self)
            if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
                
                if JSONSerialization.isValidJSONObject(nestedJson) {
                    let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
                    return try decoder.decode(D.self, from: nestedJsonData)
                } else {
                    let wrappedJsonObject = ["value": nestedJson]
                    let nestedJsonData = try JSONSerialization.data(withJSONObject: wrappedJsonObject)
                    return try decoder.decode(DecodableWrapper<D>.self, from: nestedJsonData).value
                }
            } else {
                throw DecodingError.dataCorrupted(.init(
                    codingPath: [],
                    debugDescription: "Nested JSON not found for key path \"\(keyPath)\"")
                )
            }
        } else {
            return try decoder.decode(D.self, from: self)
        }
    }
    
    private struct DecodableWrapper<T: Decodable>: Decodable {
        let value: T
    }
}

