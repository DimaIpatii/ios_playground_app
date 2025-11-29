//
//  CreateTaskRequestDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


struct UpdatedTaskRequestDTO: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    
    init(id: Int, todo: String, completed: Bool, userId: Int) {
        self.id = id
        self.todo = todo
        self.completed = completed
        self.userId = userId
    }
    
    init(from taskDTO: TaskDTO) {
        self.id = taskDTO.id
        self.todo = taskDTO.todo
        self.completed = taskDTO.completed
        self.userId = taskDTO.userId
    }
}
