//
//  DataError.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 19/11/25.
//

import Foundation

enum DataError: AppError {
    case notFound
    case saveFailed(name: String)
    case createFailed(name: String)
    case deleteFailed(name: String)
    case decodeFailed(Error)
    case updateFailed(name: String)
    
    var title: String {
        "Data Error"
    }
    
    var message: String {
        switch self {
            
        case .notFound:
            "The requested item could nopt be founded."
        case .saveFailed(let itemName):
            "Failed to save \(itemName)."
        case .deleteFailed(let fileName):
            "Failed to delete \(fileName)."
        case .decodeFailed(let error):
            "Failed decoding data. Error: \(error.localizedDescription)"
        case .updateFailed(let fileName):
            "Failed to update \(fileName)"
        case .createFailed(let fileName):
            "Failed creating \(fileName)"
        }
    }
    
    var code: Int {
        switch self {
            
        case .notFound:
            4001
        case .saveFailed:
            4002
        case .deleteFailed:
            4003
        case .decodeFailed(_):
            4004
        case .updateFailed:
            4005
        case .createFailed:
            4006
        }
    }
    
    var errorDescription: String? {
        return message
    }
}
