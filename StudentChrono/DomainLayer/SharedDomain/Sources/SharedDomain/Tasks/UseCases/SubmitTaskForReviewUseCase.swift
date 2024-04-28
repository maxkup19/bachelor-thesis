//
//  SubmitTaskForReviewUseCase.swift
//
//
//  Created by Maksym Kupchenko on 28.04.2024.
//

import Spyable

@Spyable
public protocol SubmitTaskForReviewUseCase {
    func execute(taskId: String) async throws -> Task
}

public struct SubmitTaskForReviewUseCaseImpl: SubmitTaskForReviewUseCase {
    
    private let taskRepository: TaskRepository
    
    public init(taskRepository: TaskRepository) {
        self.taskRepository = taskRepository
    }
    
    public func execute(taskId: String) async throws -> Task {
        try await taskRepository.changeTaskState(.init(taskId: taskId, taskState: .review))
    }
}
