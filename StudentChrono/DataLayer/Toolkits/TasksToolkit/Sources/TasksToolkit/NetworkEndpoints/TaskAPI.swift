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
    case getMyTasks
    case getTaskById(_ id: String)
    case getTasksForStudent(_ id: String)
}

extension TaskAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .createTask: "/task"
        case .getMyTasks: "/task/my"
        case .getTaskById: "/task"
        case .getTasksForStudent: "/task/all"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .createTask: .post
        case .getMyTasks: .get
        case .getTaskById: .get
        case .getTasksForStudent: .get
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
        case .getMyTasks: .requestPlain
        case .getTaskById: .requestPlain
        case .getTasksForStudent: .requestPlain
        }
    }
}
