//
//  UserService.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 10/11/25.
//

import Foundation

protocol UserService {
    
    func getUser(id: Int) async throws -> UserDTO
    
    func createUser(data: UserDTO) async throws -> UserDTO
    
    func updateUser(id: Int, data: UpdateUserRequestDTO) async throws -> UserDTO
    
    func deleteUser(id: Int) async throws -> Void
    
}
