//
//  NetworkStatusCode.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

public enum NetworkStatusCode: Int {
    case badRequest = 400
    case unauthorised = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case conflict = 409
    case internalServerError = 500
    case unknown = 0
}
