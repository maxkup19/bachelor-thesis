//
//  UserModelFieldKeys.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

import Fluent

extension UserModel {
    struct FieldKeys {
        static var name: FieldKey {"name"}
        static var lastname: FieldKey {"lastname"}
        static var email: FieldKey {"email"}
        static var password: FieldKey {"password"}
        static var role: FieldKey {"role"}
        static var createdAt: FieldKey {"createdAt"}
        static var updatedAt: FieldKey {"updatedAt"}
    }
}
