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
    case getTaskById(String)
}

extension TaskAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .createTask: "/task"
        case .getMyTasks: "/task/all"
        case .getTaskById(let id): "/task?taskId=\(id)"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .createTask: .post
        case .getMyTasks: .get
        case .getTaskById: .get
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .createTask(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .getMyTasks: .requestPlain
        case .getTaskById: .requestPlain
        }
    }
}
