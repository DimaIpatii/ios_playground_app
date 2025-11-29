//
//  UserServiceImpl.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 10/11/25.
//

import Foundation


final class UserServiceImpl: UserService {
    
    private let networkService: NetworkManager
    
    init(
        networkService: NetworkManager
    ){
        self.networkService = networkService
    }
    
    func getUser(id: Int) async throws -> UserDTO {
        
        print("Get user by id: \(id)")
        return UserDTO.test
        
    }
    
    func createUser(data: UserDTO) async throws -> UserDTO {
        
        guard let userJsonData = try? JSONEncoder().encode(data),
              let userJsonString = String(data: userJsonData, encoding: .utf8) else {
            print("Failed encoding user dto")
            throw EncodingError.invalidValue("", EncodingError.Context(codingPath: [], debugDescription: "Failed encoding user dto"))
        }
        
        print("Create user: \(userJsonString)")
        return UserDTO.test
    }
    
    func updateUser(id: Int, data: UpdateUserRequestDTO) async throws -> UserDTO {
        
        print("Update user with id: \(id) data: \(data)")
        return UserDTO.test
    }
    
    func deleteUser(id: Int) async throws {
        print("Delete user with id: \(id)")
    }
    
}
