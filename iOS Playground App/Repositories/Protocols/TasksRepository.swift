//
//  TasksRepository.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


protocol TasksRepository {
    
    func getAllTasks(by userId: UserId) async throws -> [UserTask]
    
    func updateTask(for taskId: TaskId, data: UserTask) async throws -> UserTask
    
    func createTask(for userId: UserId, title: String) async throws -> UserTask
    
    func deleteTask(with taskId: TaskId) async throws -> Void
    
}
