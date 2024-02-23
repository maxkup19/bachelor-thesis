//
//  Encodable+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public extension Encodable {
    func encode() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(self)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw EncodingError.invalidValue(data, .init(codingPath: [], debugDescription: "Object can't be encoded"))
        }
        return json
    }
}
