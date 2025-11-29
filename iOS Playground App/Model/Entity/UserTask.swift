//
//  Task.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


struct UserTask: Identifiable, Equatable, Hashable {
    let id: TaskId
    let title: String
    let completed: Bool
}

extension UserTask {
    
    func copyWith(
        title: String? = nil,
        completed: Bool? = nil
    ) -> UserTask {
        return UserTask(
            id: self.id,
            title: title ?? self.title,
            completed: completed ?? self.completed
        )
    }
    
    static let testModel: UserTask = UserTask(
        id: "12",
        title: "Task",
        completed: false
    )
    
}
