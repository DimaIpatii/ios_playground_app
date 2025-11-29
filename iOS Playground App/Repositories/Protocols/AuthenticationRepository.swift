//
//  AuthenticationRepository.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation


protocol AuthenticationRepository {
    
    func signIn(email: String, password: String) async throws -> Int
    
    func signUp(email: String, password: String, name: String) async throws
    
    func requestPasswordReset(email: String) async throws
    
    func signOut()
    
}
