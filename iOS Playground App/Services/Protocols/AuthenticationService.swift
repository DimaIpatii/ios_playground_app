//
//  AuthenticationService.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation


protocol AuthenticationService {
    
    func signIn(email: String, password: String) async throws -> AuthenticationResponseDTO
    
    func signUp(email: String, password: String, name: String) async throws
    
    func requestPasswordReset(with email: String) async throws
    
    func signOut()
    
}
