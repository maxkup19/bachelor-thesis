//
//  TaskRepository.swift
//  
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import NetworkProvider
import SharedDomain

public struct TaskRepositoryImpl: TaskRepository {
    
    private let network: NetworkProvider
    
    public init(
        network: NetworkProvider
    ) {
        self.network = network
    }
    
    public func createTask(_ payload: CreateTaskData) async throws {
        try await network.request(TaskAPI.createTask, withInterceptor: false)
    }
}
