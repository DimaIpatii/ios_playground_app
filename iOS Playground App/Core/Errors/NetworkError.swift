//
//  NetworkError.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 17/11/25.
//

import Foundation


enum NetworkError: AppError {
    case noConnection
    case notFound
    case serverError(statusCode: Int)
    case invalidResponse
    case uknnown(Error)
    case decodingFailed(Error)
    
    var title: String {
        return "Network Error"
    }
    
    var message: String {
        switch self {
        case .noConnection:
            "No network connection. Please check your network and try again."
        case .notFound:
            "The request resource could not be found."
        case .serverError(statusCode: let statusCode):
            "Server error occurred (Code: \(statusCode). Please try again later."
        case .invalidResponse:
            "Received invalid response from server."
        case .uknnown(let error):
            "An unexpected error occurred: \(error.localizedDescription)"
        case .decodingFailed(let error):
            "Failed to decode response: \(error.localizedDescription)"
        }
    }
    
    var code: Int {
        switch self {
        case .noConnection:
            return 1001
        case .notFound:
            return 1002
        case .serverError(statusCode: let statusCode):
            return statusCode
        case .invalidResponse:
            return 1003
        case .uknnown:
            return 1004
        case .decodingFailed(_):
            return 1005
        
        }
    }
    
    var errorDescription: String? {
        return message
    }
    
    var recoverySuggestion: String? {
        switch self {
            
        case .noConnection:
            "Check your WI-FI or cellular network and try again."
            
        case .notFound:
            "The resource you are looking for might have been deleted or moved."
            
        case .serverError(statusCode: let statusCode):
            "Wait a moment and try again."
            
        default:
            "Try again or contact support."
        }
    }
}
