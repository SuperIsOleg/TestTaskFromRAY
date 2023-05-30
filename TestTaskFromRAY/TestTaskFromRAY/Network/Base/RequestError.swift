//
//  RequestError.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 30.05.23.
//

import Foundation

enum RequestError: Error, Equatable {
    case decode
    case invalidURL
    case noResponse
    case badRequest // 400
    case notAuthorized // 401
    case notFound(message: String? = nil) // 404
    case methodNotAllowed // 405
    case unexpectedCode // other codes
    case taskError
    case message(message: String?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .decode:
            return "Can't decode"
        case .invalidURL:
            return "Request URL is not valid"
        case .noResponse:
            return "No response from server"
        case .badRequest:
            return "Bad request"
        case .notAuthorized:
            return "Not authorized"
        case .notFound(let message):
            return message ?? "Not found"
        case .methodNotAllowed:
            return "Method not allowed"
        case .unexpectedCode:
            return "Unexpected code :("
        case .taskError:
            return "Task error"
        case .message(let message):
            return message ?? "No error message"
        case .unknown:
            return "Unknown"
        }
    }
}
