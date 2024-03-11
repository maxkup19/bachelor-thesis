//
//  Repositories.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import AuthToolkit
import Factory
import FeedbackToolkit
import SharedDomain
import StudentsToolkit
import TasksToolkit
import UserToolkit

public extension Container {
    var authRepository: Factory<AuthRepository> { self { AuthRepositoryImpl(
        keychainProvider: self.keychainProvider(),
        networkProvider: self.networkProvider()
    )}}
    var userRepository: Factory<UserRepository> { self { UserRepositoryImpl(
        networkProvider: self.networkProvider()
    )}}
    var taskRepository: Factory<TaskRepository> { self { TaskRepositoryImpl(
        networkProvider: self.networkProvider()
    )}}
    var studentsRepository: Factory<StudentsRepository> { self {
        StudentsRepositoryImpl(
            network: self.networkProvider()
    )}}
    var feedbackRepository: Factory<FeedbackRepository> { self {
        FeedbackRepositoryImpl(
            network: self.networkProvider()
    )}}
}
