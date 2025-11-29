//
//  AuthenticationError.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 19/11/25.
//

import Foundation


enum AuthenticationError: AppError {
    
    case invalidCredentials
    case emailAlreadyExist
    case weakPassword(passwordRule: String)
    case userNotFound
    case tokenExpired
    case tokenInvalid
    case registrationFailed(Error)
    
    var title: String {
        return "Authentication Error"
    }
    
    var message: String {
        switch self {
            
        case .invalidCredentials:
            "Email or password is incorrect"
        case .emailAlreadyExist:
            "This email is already registered"
        case .weakPassword(passwordRule: let rule):
            "Password must contain \(rule)"
        case .userNotFound:
            "No account found with this email."
        case .tokenExpired:
            "Your session has expired. Please, try signing in again."
        case .tokenInvalid:
            "Invalid session. Please try signing in again."
        case .registrationFailed(let error):
            "Registration failed: \(error.localizedDescription)"
        }
    }
    
    var errorDescription: String? {
        return message
    }
    
    var code: Int {
        
        switch self {
            
        case .invalidCredentials:
            2001
        case .emailAlreadyExist:
            2002
        case .weakPassword:
            2003
        case .userNotFound:
            2004
        case .tokenExpired:
            2005
        case .tokenInvalid:
            2006
        case .registrationFailed(_):
            2007
        }
        
    }
    
}
