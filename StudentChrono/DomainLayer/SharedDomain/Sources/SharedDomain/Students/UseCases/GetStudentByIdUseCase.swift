//
//  GetStudentByIdUseCase.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import Spyable

@Spyable
public protocol GetStudentByIdUseCase {
    func execute(id: String) async throws -> User
}

public struct GetStudentByIdUseCaseImpl: GetStudentByIdUseCase {
    
    private let studentsRepository: StudentsRepository
    
    public init(studentsRepository: StudentsRepository) {
        self.studentsRepository = studentsRepository
    }
    
    public func execute(id: String) async throws -> User {
        try await studentsRepository.getStudentById(id)
    }
}
