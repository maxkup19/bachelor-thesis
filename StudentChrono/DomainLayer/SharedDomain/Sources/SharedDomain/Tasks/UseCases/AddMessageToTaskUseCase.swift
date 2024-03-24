//
//  AddMessageToTaskUseCase.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Spyable

@Spyable
public protocol AddMessageToTaskUseCase {
    func execute(_ payload: AddMessageToTaskData) async throws -> Task
}

public struct AddMessageToTaskUseCaseImpl: AddMessageToTaskUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(_ payload: AddMessageToTaskData) async throws -> Task {
        try await taskRepository.addMessageToTask(payload)
    }
}
