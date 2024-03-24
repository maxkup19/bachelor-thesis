//
//  MessageFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Fluent

extension Message {
    struct FieldKeys {
        static var authorId: FieldKey {"authorId"}
        static var text: FieldKey {"text"}
        static var file: FieldKey {"file"}
        static var createdAt: FieldKey {"createdAt"}
    }
}
