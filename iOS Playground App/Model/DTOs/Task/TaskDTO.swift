//
//  TaskDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


struct TaskDTO: Codable {
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
    
    init(
        from task: UserTask,
        userId: Int
    ) {
        self.id = Int(task.id) ?? -1
        self.todo = task.title
        self.completed = task.completed
        self.userId = userId
    }
}

extension TaskDTO {
    
    func toDomain() -> UserTask {
        return UserTask(
            id: String(self.id),
            title: self.todo,
            completed: self.completed
        )
    }
    
    func updateTask(
        data: UpdatedTaskRequestDTO
    ) -> TaskDTO {
        
        return TaskDTO(
            id: self.id,
            todo: data.todo,
            completed: data.completed,
            userId: self.userId
        )
    }
}
