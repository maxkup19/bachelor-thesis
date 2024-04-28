//
//  TaskRepository.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Spyable

@Spyable
public protocol TaskRepository {
    func createTask(_ payload: CreateTaskData) async throws
    func updateTask(_ payload: UpdateTaskData) async throws
    func changeTaskState(_ payload: ChangeTaskStateData) async throws -> Task
    func getMyTasks() async throws -> [Task]
    func getTaskById(id: String) async throws -> Task
    func getStudentsTasks(id: String) async throws -> [Task]
    func addMessageToTask(_ payload: AddMessageToTaskData) async throws -> Task
}
