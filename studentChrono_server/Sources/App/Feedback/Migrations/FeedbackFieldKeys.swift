//
//  FeedbackFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Fluent

extension Feedback {
    struct FieldKeys {
        static var email: FieldKey {"email"}
        static var description: FieldKey {"description"}
        static var screenshotName: FieldKey {"screenshotName"}
        static var status: FieldKey {"status"}
        static var createdAt: FieldKey {"createdAt"}
        static var updatedAt: FieldKey {"updatedAt"}
    }
}
