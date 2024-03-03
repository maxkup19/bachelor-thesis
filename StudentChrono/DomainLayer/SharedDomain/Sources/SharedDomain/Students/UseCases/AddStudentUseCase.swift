//
//  AddStudentUseCase.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Spyable

@Spyable
public protocol AddStudentUseCase {
    func execute(_ data: AddStudentData) async throws
}

public struct AddStudentUseCaseImpl: AddStudentUseCase {
    
    private let studentsRepository: StudentsRepository
    
    public init(studentsRepository: StudentsRepository) {
        self.studentsRepository = studentsRepository
    }
    
    public func execute(_ data: AddStudentData) async throws {
        try await studentsRepository.addStudent(data)
    }
}
