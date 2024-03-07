//
//  GetTaskByIdUseCase.swift
//
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Spyable

@Spyable
public protocol GetTaskByIdUseCase {
    func execute(taskId: String) async throws -> Task
}

public struct GetTaskByIdUseCaseImpl: GetTaskByIdUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(taskId: String) async throws -> Task {
        try await taskRepository.getTaskById(id: taskId)
    }
}
