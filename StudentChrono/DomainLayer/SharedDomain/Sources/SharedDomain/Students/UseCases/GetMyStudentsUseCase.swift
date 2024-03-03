//
//  GetMyStudentsUseCase.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Spyable

@Spyable
public protocol GetMyStudentsUseCase {
    func execute() async throws -> [User]
}

public struct GetMyStudentsUseCaseImpl: GetMyStudentsUseCase {
    
    private let studentsRepository: StudentsRepository
    
    public init(studentsRepository: StudentsRepository) {
        self.studentsRepository = studentsRepository
    }
    
    public func execute() async throws -> [User] {
        try await studentsRepository.getMyStudents()
    }
    
}
