//
//  FeedbackAPI.swift
//  
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import Foundation
import NetworkProvider
import Utilities

enum FeedbackAPI {
    case feedback(_ data: [String: Any])
}

extension FeedbackAPI: NetworkEndpoint {
    var baseURL: URL { URL(string: NetworkingConstants.baseURL)! }
    var path: String {
        switch self {
        case .feedback: "feedback"
        }
    }
    var method: NetworkMethod {
        switch self {
        case .feedback: .post
        }
    }
    var headers: [String : String]? {
        nil
    }
    var task: NetworkTask {
        switch self {
        case .feedback(let data): .requestParameters(parameters: data, encoding: JSONEncoding.default)
        }
    }
    
}
