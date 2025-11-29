//
//  Validator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import Foundation


final class Validator {
    
    static let shared = Validator()
    
    private init() {}
    
    func validateEmail(_ email: String) throws {
        
        guard email.trim().isEmpty == false else {
            throw ValidationError.emptyField(fieldName: "Email")
        }
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            throw ValidationError.invalidEmail
        }
        
    }
    
    func validatePassword(_ password: String) throws {
        
        let trimedPassword = password.trim()
        
        // Password requirements
        let passwordLength = 8
        
        // Length check
        if (trimedPassword.isEmpty || trimedPassword.count < passwordLength) {
            throw ValidationError.fieldTooShort(fieldName: "Password", minLength: passwordLength)
        }
        
        // Uppercase check
        if trimedPassword.rangeOfCharacter(from: .uppercaseLetters) == nil {
            throw ValidationError.missedUppercase
        }
        
        // Lovercase check
        if trimedPassword.rangeOfCharacter(from: .lowercaseLetters) == nil {
            throw ValidationError.missedLowercase
        }
        
        // Number check
        if trimedPassword.rangeOfCharacter(from: .decimalDigits) == nil {
            throw ValidationError.missedNumber
        }
        
        // Character check
        let containsSymbols = trimedPassword.unicodeScalars.contains {
            CharacterSet.symbols
                .union(.punctuationCharacters)
                .contains($0)
        }

        if containsSymbols == false {
            throw ValidationError.missedSymbol
        }
        
        
    }
    
    
    
}
