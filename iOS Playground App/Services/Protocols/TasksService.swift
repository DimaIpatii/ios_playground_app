//
//  TasksService.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


protocol TasksService {
    
    func getAllTask(by userId: UserId) async throws -> [TaskDTO]
    
    func createTask(for userId: UserId, data: CreateTaskRequestDTO) async throws -> TaskDTO
    
    func deleteTask(with taskId: TaskId) async throws -> Void
    
    func updatedTask(with taskId: TaskId, data: UpdatedTaskRequestDTO) async throws -> TaskDTO
    
}
