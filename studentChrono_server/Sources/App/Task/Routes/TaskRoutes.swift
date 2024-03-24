//
//  TaskRoutes.swift
//
//
//  Created by Maksym Kupchenko on 24.02.2024.
//

import Vapor

enum TaskRoutes {
    static let base: PathComponent = "task"
    static let all: PathComponent = "all"
    static let my: PathComponent = "my"
    
    static let message: PathComponent = "message"
    
    enum Parameter {
        static let taskId: String = "taskId"
        static let studentId: String = "studentId"
    }
}
