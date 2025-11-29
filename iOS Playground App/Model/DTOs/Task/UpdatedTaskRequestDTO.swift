//
//  CreateTaskRequestDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


struct UpdatedTaskRequestDTO: Codable {
    let todo: String
    let completed: Bool
    
    
    init(
        todo: String,
        completed: Bool
    ) {
        self.todo = todo
        self.completed = completed
    }
    
    
    init(from taskDTO: TaskDTO) {
        self.todo = taskDTO.todo
        self.completed = taskDTO.completed
    }
    
    init(from task: UserTask) {
        self.todo = task.title
        self.completed = task.completed
    }
}
