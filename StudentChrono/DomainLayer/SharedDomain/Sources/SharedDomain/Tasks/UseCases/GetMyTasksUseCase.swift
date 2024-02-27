//
//  GetMyTasksUseCase.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Spyable

@Spyable
public protocol GetMyTasksUseCase {
    func execute() async throws -> [Task]
}

public struct GetMyTasksUseCaseImpl: GetMyTasksUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute() async throws -> [Task] {
        try await taskRepository.getMyTasks()
    }
}
