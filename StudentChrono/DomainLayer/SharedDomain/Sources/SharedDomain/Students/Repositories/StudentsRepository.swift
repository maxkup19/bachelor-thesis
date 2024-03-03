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
    func getMyStudents() async throws -> [User]
}
