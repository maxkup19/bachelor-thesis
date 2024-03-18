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
    case removeStudent(_ data: [String: Any])
    case getMyStudents
    case getStudentById(_ id: String)
}

extension StudentsAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .addStudent: "/students"
        case .removeStudent: "/students"
        case .getMyStudents: "/students/mine"
        case .getStudentById(let id): "/students?studentId=\(id)"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .addStudent: .patch
        case .removeStudent: .delete
        case .getMyStudents: .get
        case .getStudentById: .get
        }
    }
    var headers: [String: String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case let .addStudent(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case let .removeStudent(data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .getMyStudents: .requestPlain
        case .getStudentById: .requestPlain
        }
    }
}
