//
//  UserDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation

struct UserDTO: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    
    init(
        id: Int,
        firstName: String,
        lastName: String,
        email: String
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    init(from user: User) {
        
        let userName = user.name.split(separator: " ")
        let firstName = String(userName.first ?? "")
        let lastName = String(userName.last ?? "")
        
        self.id = Int(user.id) ?? -1
        self.firstName = firstName
        self.lastName = lastName
        self.email = user.email
                
    }
    
}

extension UserDTO {

    func toDomain() -> User {
        let fullName = firstName + " " + lastName
        return User(id: String(id), name: fullName, email: email)
    }
    
}

// MARK: - TEST DATA
extension UserDTO {
 
    static var test: UserDTO {
        return UserDTO(
            id: 162,
            firstName: "John",
            lastName: "Smith",
            email: "john@smith.com"
        )
    }
    
}


