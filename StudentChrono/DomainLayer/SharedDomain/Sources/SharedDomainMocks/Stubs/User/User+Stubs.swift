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
        lastName: "Anonymous",
        email: "email@email.com",
        role: .student,
        birthDay: .distantPast
    )
    
    static let teacherStub = User(
        name: "Anonymous",
        lastName: "Anon",
        email: "email@email",
        role: .teacher,
        birthDay: .distantPast
    )
}
