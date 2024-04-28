//
//  CloseTaskUseCase.swift
//
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Spyable

@Spyable
public protocol CloseTaskUseCase {
    func execute(taskId: String) async throws -> Task
}

public struct CloseTaskUseCaseImpl: CloseTaskUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(taskId: String) async throws -> Task {
        try await taskRepository.changeTaskState(.init(taskId: taskId, taskState: .done))
    }
}
