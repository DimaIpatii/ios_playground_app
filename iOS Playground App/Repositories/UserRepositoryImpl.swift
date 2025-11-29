//
//  UserRepositoryImpl.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 12/11/25.
//

import Foundation


final class UserRepositoryImpl: UserRepository {

    private let userService: UserService
    
    init(service: UserService) {
        self.userService = service
    }
    
}

extension UserRepositoryImpl {
    
    func getUser(id: Int) async throws -> User {
        let userDTO = try await userService.getUser(id: id)
        
        return userDTO.toDomain()
    }
    
    func createUser(user: User) async throws -> User {
        
        let userDTO = UserDTO(from: user)
        
        let createdUserDTO = try await userService.createUser(data: userDTO)
        
        return createdUserDTO.toDomain()
    }
    
    func updateUser(user: User) async throws -> User {
        
        let requestData = UpdateUserRequestDTO(from: user)
        
        let updatedUserDTO = try await userService.updateUser(id: Int(user.id) ?? -1, data: requestData)
        
        return updatedUserDTO.toDomain()
    }
    
    func deleteUser(id: Int) async throws {
        
        try await userService.deleteUser(id: id)
        
    }
    
}
