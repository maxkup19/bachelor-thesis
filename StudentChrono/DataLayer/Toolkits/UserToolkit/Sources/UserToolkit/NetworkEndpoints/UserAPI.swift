//
//  UserAPI.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Foundation
import NetworkProvider
import Utilities

enum UserAPI {
    case currentUser
    case updateInfo(_ data: [String: Any])
    case verifyPassword(_ data: [String: Any])
    case updatePassword(_ data: [String: Any])
    case deleteAccount
}

extension UserAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .currentUser: "/user/me"
        case .updateInfo: "/user/info"
        case .verifyPassword: "/user/password"
        case .updatePassword: "/user/password"
        case .deleteAccount: "/user/deleteAccount"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .currentUser: .get
        case .updateInfo: .patch
        case .verifyPassword: .post
        case .updatePassword: .patch
        case .deleteAccount: .delete
        }
    }
    var headers: [String : String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case .currentUser: .requestPlain
        case .updateInfo(let data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .verifyPassword(let data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .updatePassword(let data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        case .deleteAccount: .requestPlain
        }
    }
}
