//
//  RemoveStudentUseCase.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import Spyable

@Spyable
public protocol RemoveStudentUseCase {
    func execute(_ payload: RemoveStudentData) async throws
}

public struct RemoveStudentUseCaseImpl: RemoveStudentUseCase {
    
    private let studentsRepository: StudentsRepository
    
    public init(studentsRepository: StudentsRepository) {
        self.studentsRepository = studentsRepository
    }
    
    public func execute(_ payload: RemoveStudentData) async throws {
        try await studentsRepository.removeStudent(payload)
    }
}
