//
//  UserFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent

extension User {
    struct FieldKeys {
        static var name: FieldKey {"name"}
        static var lastName: FieldKey {"lastname"}
        static var email: FieldKey {"email"}
        static var password: FieldKey {"password"}
        static var role: FieldKey {"role"}
        static var birthDay: FieldKey {"birthday"}
        static var tasks: FieldKey {"tasks"}
        static var createdAt: FieldKey {"createdAt"}
        static var updatedAt: FieldKey {"updatedAt"}
    }
}
