//
//  User+Stubs.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SharedDomain

public extension User {
    static let studentStub = User(
        id: "1",
        name: "Anon",
        lastName: "Anonymous",
        email: "email@email.com",
        role: .student,
        birthDay: .distantPast,
        imageURL: nil
    )
    
    static let teacherStub = User(
        id: "2",
        name: "Anonymous",
        lastName: "Anon",
        email: "email@email",
        role: .teacher,
        birthDay: .distantPast,
        imageURL: nil
    )
}
