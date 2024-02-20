//
//  User+Stubs.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SharedDomain

public extension User {
    static let studentStub = User(
        name: "Anon",
        lastname: "Anonymous",
        email: "email@email.com",
        role: UserRoleEnum.student
    )
    
    static let teacherStub = User(
        name: "Anonymous",
        lastname: "Anon",
        email: "email@email",
        role: UserRoleEnum.teacher
    )
}
