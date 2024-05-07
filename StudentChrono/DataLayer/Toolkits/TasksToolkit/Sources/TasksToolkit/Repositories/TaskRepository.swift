//
//  TaskRepository.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import FirebaseStorage
import NetworkProvider
import SharedDomain

public struct TaskRepositoryImpl: TaskRepository {
    
    private let network: NetworkProvider
    private let storage: Storage
    
    public init(
        networkProvider: NetworkProvider
    ) {
        network = networkProvider
        storage = Storage.storage()
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
    
    public func changeTaskState(_ payload: ChangeTaskStateData) async throws -> Task {
        let data = try payload.networkModel.encode()
        do {
            return try await network.request(TaskAPI.changeTaskState(data), withInterceptor: false)
                .map(NETTask.self)
                .domainModel
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
        do {
            var fileURL: String?
            
            if let file = payload.file {
                let reference = storage.reference().child(file.filename)
                let _ = try await reference.putDataAsync(file.data)
                fileURL = try await reference.downloadURL().absoluteString
            }
            
            let data = try payload.networkModel(file: fileURL).encode()
            return try await network.request(TaskAPI.addMessageToTask(data), withInterceptor: false)
                .map(NETTask.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw TasksError.tasksError(description: message?.reason)
        } catch {
            print("DEBBUG: \(error)")
            throw error
        }
    }
}
