//
//  StudentsRepository.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Spyable

@Spyable
public protocol StudentsRepository {
    func addStudent(_ payload: AddStudentData) async throws
    func removeStudent(_ payload: RemoveStudentData) async throws
    func getStudentById(_ id: String) async throws -> User
    func getMyStudents() async throws -> [User]
}
