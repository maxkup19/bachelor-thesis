//
//  UpdateTaskUseCase.swift
//
//
//  Created by Maksym Kupchenko on 27.03.2024.
//

import Spyable

@Spyable
public protocol UpdateTaskUseCase {
    func execute(_ payload: UpdateTaskData) async throws
}

public struct UpdateTaskUseCaseImpl: UpdateTaskUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(_ payload: UpdateTaskData) async throws {
        try await taskRepository.updateTask(payload)
    }
}
