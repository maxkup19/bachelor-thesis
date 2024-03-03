//
//  StudentsAPI.swift
//  
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import Foundation
import NetworkProvider
import Utilities

enum StudentsAPI {
    case addStudent(_ data: [String: Any])
    case getMyStudents
}

extension StudentsAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .addStudent: "/students"
        case .getMyStudents: "/students/mine"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .addStudent: .patch
        case .getMyStudents: .get
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .addStudent(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .getMyStudents: .requestPlain
        }
    }
}
