//
//  AuthenticationRepositoryImpl.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation


final class AuthenticationRepositoryImpl: AuthenticationRepository {
    
    private let service: AuthenticationService
    
    init(service: AuthenticationService) {
        self.service = service
    }
    
    func signIn(email: String, password: String) async throws -> Int {
        
        do {
            let credentialsDTO = try await service.signIn(email: email, password: password)
            
            Logger.info(message: "Logged in successfuly")
            return credentialsDTO.userId
            
        } catch let error as AuthenticationError {
            
            Logger.error(message: "Failed authenticated: Error message \(error.message)")
            
            throw error
            
        } catch {
            
            Logger.error(message: "Unexpected error occurred during authenticated: Error message \(error.localizedDescription)")
            
            throw error
        }
        
    }
    
    func signUp(email: String, password: String, name: String) async throws {
        
        do {
            try await service.signUp(email: name, password: password, name: name)
            
            Logger.info(message: "Signed up successfuly")
        } catch let error as AuthenticationError {
            
            Logger.error(message: "Failed signing up with error: Error message \(error.message)")
            throw error
            
        } catch {
            
            Logger.error(message: "Unexpected error occurred during signed up: Error message \(error.localizedDescription)")
            
            throw error
        }
        
        
    }
    
    func requestPasswordReset(email: String) async throws {
        
        do {
            
            try await service.requestPasswordReset(with: email)
            
            Logger.info(message: "Password reset email sent")
            
        } catch let error as AuthenticationError {
            
            Logger.error(message: "Failed sending password email: Error message \(error.message)")
            
            throw error
            
        } catch {
            
            Logger.error(message: "Unexpected error occurred during password reset: Error message \(error.localizedDescription)")
            
            throw error
        }
        
    }
    
    func signOut() {
        
        service.signOut()
    }
    
    
}
