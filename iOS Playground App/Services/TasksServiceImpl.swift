//
//  TasksService.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation

final class TasksServiceImpl: TasksService {
    
    private let networkService: NetworkManager
    
    private var tasks: [TaskDTO] = []
    
    init(
        networkService: NetworkManager
    ){
        self.networkService = networkService
    }
    
    func getAllTask(by userId: UserId) async throws -> [TaskDTO] {
        
        do {
            
            guard tasks.isEmpty else  {
                
                await TaskUtility.shared.delay()
                
                return tasks
            }
            
            tasks = try await getMockTasks()
            return tasks
             
        } catch {
            
            throw error
            
        }
        
    }
    
    func createTask(for userId: UserId, data: CreateTaskRequestDTO) async throws -> TaskDTO {
        
        do {
            
            await TaskUtility.shared.delay()
            
            let userIdInt = Int(userId) ?? -1
            
            let newTask = TaskDTO(
                id: Int.random(in: 0..<1000),
                todo: data.todo,
                completed: data.completed,
                userId: userIdInt
            )
            
            tasks.insert(newTask, at: 0)
            
            return newTask
            
        } catch {
            
            throw error
        }
        
    }
    
    func deleteTask(with taskId: TaskId) async throws {
        
        do {
            
            await TaskUtility.shared.delay()
            
            let numbTask = Int(taskId) ?? -1
            
            tasks = tasks.filter({$0.id != numbTask})
            
            Logger.info(message: "Successfully deleted task with id: \(taskId)")
            
        } catch {
            
            throw error
            
        }
    }
    
    func updatedTask(with taskId: TaskId, data: UpdatedTaskRequestDTO) async throws -> TaskDTO {
        
        do {
            
            
            let taskIntId = Int(taskId) ?? -1
            
            guard let curentTask = tasks.first(where: {$0.id == taskIntId}) else {
                throw DataError.notFound
            }

            let updatedTask = curentTask.updateTask(data: data)
            
            tasks = tasks.map({ task in
                
                guard task.id == updatedTask.id else {
                    return task
                }
                
                return updatedTask
                
            })
            
            return updatedTask

        } catch {
            throw error
        }
    }
    
    
    private func getMockTasks() async throws -> [TaskDTO] {
        
        await TaskUtility.shared.delay()
        
        let jsonData = mockTasksJSONResponse.data(using: .utf8)!
        
        
        let tasksResponse = try JSONDecoder().decode(TaskResponseDTO.self, from: jsonData)
        
        guard tasksResponse.todos.isEmpty == false else {
            throw DataError.notFound
        }
        return tasksResponse.todos
        
    }
}
