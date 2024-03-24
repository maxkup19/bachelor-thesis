//
//  TaskFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Fluent

extension Task {
    struct FieldKeys {
        static var title: FieldKey {"title"}
        static var description: FieldKey {"description"}
        static var tags: FieldKey {"tags"}
        static var comments: FieldKey {"comments"}
        static var state: FieldKey {"state"}
        static var authorId: FieldKey {"authorId"}
        static var assigneeId: FieldKey {"assigneeId"}
        static var priority: FieldKey {"priority"}
        static var dueTo: FieldKey {"dueTo"}
        static var createdAt: FieldKey {"createdAt"}
        static var updatedAt: FieldKey {"updatedAt"}
    }
}
