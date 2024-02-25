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
    case deleteAccount
}

extension UserAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .currentUser: "/user/me"
        case .deleteAccount: "/user/deleteAccount"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .currentUser: .get
        case .deleteAccount: .delete
        }
    }
    var headers: [String : String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case .currentUser: .requestPlain
        case .deleteAccount: .requestPlain
        }
    }
}
