//
//  GetTasksForStudentUseCase.swift
//
//
//  Created by Maksym Kupchenko on 23.03.2024.
//

import Spyable

@Spyable
public protocol GetTasksForStudentUseCase {
    func execute(studentId: String) async throws -> [Task]
}

public struct GetTasksForStudentUseCaseImpl: GetTasksForStudentUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(studentId: String) async throws -> [Task] {
        try await taskRepository.getStudentsTasks(id: studentId)
    }
}
