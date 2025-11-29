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
        
        self.id = user.id
        self.firstName = firstName
        self.lastName = lastName
        self.email = user.email
                
    }
    
}

extension UserDTO {

    func toDomain() -> User {
        let fullName = firstName + " " + lastName
        return User(id: id, name: fullName, email: email)
    }
    
}

// MARK: - TEST DATA
extension UserDTO {
 
    static var test: UserDTO {
        return UserDTO(
            id: 1,
            firstName: "Dmytro",
            lastName: "Ipatii",
            email: "dima@email.com"
        )
    }
    
}


