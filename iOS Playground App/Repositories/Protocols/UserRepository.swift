//
//  UserRepository.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 12/11/25.
//

import Foundation

protocol UserRepository {
    
    func getUser(id: Int) async throws -> User
    
    func createUser(user: User) async throws -> User
    
    func updateUser(user: User) async throws -> User
 
    func deleteUser(id: Int) async throws -> Void
    
}
