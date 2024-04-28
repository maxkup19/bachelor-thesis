//
//  NetworkProviderError.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum NetworkProviderError: Error {
    case requestFailed(statusCode: NetworkStatusCode, message: NetworkProviderErrorResponse?)
}

public struct NetworkProviderErrorResponse: Decodable {
    public let error: Bool
    public let reason: String
    
    public init(
        error: Bool,
        reason: String
    ) {
        self.error = error
        self.reason = reason
    }
}
