//
//  AuthenticationServiceImpl.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation


final class AuthenticationServiceImpl: AuthenticationService {
    
    private let network: NetworkManager
    
    init(
        networkManager: NetworkManager
    ){
        self.network = networkManager
    }
    
    func signIn(email: String, password: String) async throws -> AuthenticationResponseDTO {
        
        do {
            
            try await Task.sleep(nanoseconds: 3_000_000_000)
            
            Logger.info(message: "Sign in successful")
            
            return AuthenticationResponseDTO(
                userId: 162,
                email: "emily.johnson@x.dummyjson.com",
                token: UUID().uuidString
            )
            
        } catch let error as AuthenticationError {
            
            Logger.error(message: "Failed authenticating with error: \(error.localizedDescription)")
            throw error
            
        } catch {
            
            Logger.error(message: "Unexpected error occured during sign in. Error message: \(error.localizedDescription)")
            throw error
        }
        
    }
    
    func signUp(email: String, password: String, name: String) async throws {
        
        do {
            
            print("DEBUG: Sign Up Success")
            
            try await Task.sleep(nanoseconds: 3_000_000_000)
            
        } catch {
            
        }
        
    }
    
    func requestPasswordReset(with email: String) async throws {
        
        do {
            
            print("DEBUG: Requiest password reset for: \(email)")
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
        } catch {
            
        }
        
    }
    
    func signOut() {
        print("DEBUG: Sign Out Success")
    }
    
    
}
