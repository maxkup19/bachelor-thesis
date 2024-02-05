//
//  NetworkTask.swift
//  
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public enum NetworkTask {
    /// A request with no additional data.
    case requestPlain

    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
