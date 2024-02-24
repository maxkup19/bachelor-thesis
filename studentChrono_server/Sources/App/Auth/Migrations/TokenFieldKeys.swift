//
//  TokenFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent

extension Token {
    struct FieldKeys {
        static var userId: FieldKey {"userId"}
        static var value: FieldKey {"value"}
        static var source: FieldKey {"source"}
        static var expiresAt: FieldKey {"expiresAt"}
        static var createdAt: FieldKey {"createdAt"}
    }
}
