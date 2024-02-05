//
//  NetworkProviderError.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum NetworkProviderError: Error {
    case requestFailed(statusCode: NetworkStatusCode, message: String)
}
