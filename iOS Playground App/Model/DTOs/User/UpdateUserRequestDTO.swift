//
//  UpdateUserRequestDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import Foundation


struct UpdateUserRequestDTO: Encodable {
    let name: String
    let email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    init(from user: User) {
        self.name = user.name
        self.email = user.email
    }
}
