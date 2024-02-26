//
//  CreateTaskUseCase.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Spyable

@Spyable
public protocol CreateTaskUseCase {
    func execute(_ data: CreateTaskData) async throws
}

public struct CreateTaskUseCaseImpl: CreateTaskUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(_ data: CreateTaskData) async throws {
        try await taskRepository.createTask(data)
    }
}
