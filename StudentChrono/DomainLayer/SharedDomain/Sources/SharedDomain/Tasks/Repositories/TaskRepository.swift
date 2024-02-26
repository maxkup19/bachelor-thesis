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
}
