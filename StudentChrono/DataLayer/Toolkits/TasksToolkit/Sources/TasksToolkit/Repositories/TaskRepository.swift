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
        networkProvider: NetworkProvider
    ) {
        network = networkProvider
    }
    
    public func createTask(_ payload: CreateTaskData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(TaskAPI.createTask(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
    
    public func updateTask(_ payload: UpdateTaskData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(TaskAPI.updateTask(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
    
    public func getMyTasks() async throws -> [Task] {
        do {
            return try await network.request(TaskAPI.getMyTasks, withInterceptor: false)
                .map([NETTask].self)
                .map(\.domainModel)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
    
    public func getTaskById(id: String) async throws -> Task {
        do {
            return try await network.request(TaskAPI.getTaskById(id), withInterceptor: false)
                .map(NETTask.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
    
    public func getStudentsTasks(id: String) async throws -> [Task] {
        do {
            return try await network.request(TaskAPI.getTasksForStudent(id), withInterceptor: false)
                .map([NETTask].self)
                .map(\.domainModel)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
    
    public func addMessageToTask(_ payload: AddMessageToTaskData) async throws -> Task {
        let data = try payload.networkModel.encode()
        do {
            return try await network.request(TaskAPI.addMessageToTask(data), withInterceptor: false)
                .map(NETTask.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        }
    }
}
