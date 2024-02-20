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
}

extension UserAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .currentUser: "/user/me"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .currentUser: .get
        }
    }
    var headers: [String : String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case .currentUser: .requestPlain
        }
    }
}
