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
    private let validateEmailUseCase: ValidateEmailUseCase
    
    public init(
        studentsRepository: StudentsRepository,
        validateEmailUseCase: ValidateEmailUseCase
    ) {
        self.studentsRepository = studentsRepository
        self.validateEmailUseCase = validateEmailUseCase
    }
    
    public func execute(_ data: AddStudentData) async throws {
        try validateEmailUseCase.execute(data.email)
        try await studentsRepository.addStudent(data)
    }
}
