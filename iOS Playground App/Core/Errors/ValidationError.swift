//
//  ValidationError.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 19/11/25.
//

import Foundation


enum ValidationError: AppError {
    
    case emptyField(fieldName: String)
    case invalidEmail
    case invalidPasswordFormat
    case fieldTooShort(fieldName: String, minLength: Int)
    case fieldTooLogng(fieldName: String, maxLength: Int)
    case missedUppercase
    case missedLowercase
    case missedNumber
    case missedSymbol
    
    var title: String {
        return "Validation Error"
    }
    
    var message: String {
        switch self {
            
        case .emptyField(fieldName: let fieldName):
            "\(fieldName) cannot be empty."
        case .invalidEmail:
            "Please enter a valid email address."
        case .fieldTooShort(fieldName: let fieldName, minLength: let minLength):
            "\(fieldName) must be at least \(minLength) characters long."
        case .fieldTooLogng(fieldName: let fieldName, maxLength: let maxLength):
            "\(fieldName) must be no longer than \(maxLength) characters."
        case .missedUppercase:
            "Password must contain at least one uppercase letter"
        case .missedLowercase:
            "Password must contain at least one lowercase letter"
        case .missedNumber:
            "Password must contain at least one digit"
        case .missedSymbol:
            "Password must contain at least one symbol"
        case .invalidPasswordFormat:
            "Please enter a valid password."
        }
    }
    
    var code: Int {
        switch self {
            
        case .emptyField(fieldName: let fieldName):
            3001
        case .invalidEmail:
            3002
        case .fieldTooShort(fieldName: let fieldName, minLength: let minLength):
            3003
        case .fieldTooLogng(fieldName: let fieldName, maxLength: let maxLength):
            3004
        case .missedUppercase:
            3005
        case .missedLowercase:
            3006
        case .missedNumber:
            3007
        case .missedSymbol:
            3008
        case .invalidPasswordFormat:
            3009
        }
    }
}
