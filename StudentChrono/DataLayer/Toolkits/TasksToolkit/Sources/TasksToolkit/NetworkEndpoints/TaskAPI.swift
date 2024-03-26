//
//  TaskAPI.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Foundation
import NetworkProvider
import Utilities

enum TaskAPI {
    case createTask(_ data: [String: Any])
    case updateTask(_ data: [String: Any])
    case getMyTasks
    case getTaskById(_ id: String)
    case getTasksForStudent(_ id: String)
    case addMessageToTask(_ data: [String: Any])
}

extension TaskAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .createTask: "/task"
        case .updateTask: "/task"
        case .getMyTasks: "/task/my"
        case .getTaskById: "/task"
        case .getTasksForStudent: "/task/all"
        case .addMessageToTask: "/task/message"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .createTask: .post
        case .updateTask: .patch
        case .getMyTasks: .get
        case .getTaskById: .get
        case .getTasksForStudent: .get
        case .addMessageToTask: .post
        }
    }
    var headers: [String: String]? {
        switch self {
        case .getTaskById(let id): ["taskId": id]
        case .getTasksForStudent(let id): ["studentId": id]
        default: .none
        }
    }
    var task: NetworkTask {
        switch self {
        case let .createTask(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case let .updateTask(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .getMyTasks: .requestPlain
        case .getTaskById: .requestPlain
        case .getTasksForStudent: .requestPlain
        case let .addMessageToTask(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
}
