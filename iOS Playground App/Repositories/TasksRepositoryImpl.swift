//
//  TasksRepository.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


final class UserTasksRepositoryImpl: TasksRepository {
    
    private let tasksService: TasksService
    
    init(
        tasksService: TasksService
    ) {
        self.tasksService = tasksService
    }
    
    func getAllTasks(by userId: UserId) async throws -> [UserTask] {
        
        do {
            
            let tasksDTO = try await self.tasksService.getAllTask(by: userId)
            
            Logger.info(message: "Fetched tasks with count of: \(tasksDTO.count)")
            
            return tasksDTO.map { $0.toDomain() }
            
        } catch {
            
            Logger.error(message: "Failed getting all tasks: Error \(error.localizedDescription)")
            
            throw error
        }
        
    }
    
    func updateTask(for taskId: TaskId, data: UserTask) async throws -> UserTask {
        
        do {

            let updateTaskRequest = UpdatedTaskRequestDTO(from: data)
            
            let updatedTaskDTO = try await self.tasksService.updatedTask(with: taskId, data: updateTaskRequest)
            
            Logger.info(message: "Updated task successfully: \(updatedTaskDTO)")
            return updatedTaskDTO.toDomain()
            
        } catch let error as DataError {
            
            Logger.error(message: "Data Error: \(error.message)")
            
            throw error
            
        } catch {
            
            Logger.error(message: "Failed update task: \(error)")
            
            throw DataError.updateFailed(name: "Task")
            
        }
        
    }
    
    func createTask(for userId: UserId, title: String) async throws -> UserTask {
        
        do {

            let newTaskRequest = CreateTaskRequestDTO(todo: title)
            
            let createdTaskResponse = try await self.tasksService.createTask(for: userId, data: newTaskRequest)
            
            Logger.info(message: "Task created successfully: \(createdTaskResponse)")
            
            return createdTaskResponse.toDomain()
            
        } catch let error as DataError {
            
            Logger.error(message: "Error in creating task: \(error.message)")
            
            throw error
            
        } catch {
            Logger.error(message: "Failed create task")
            
            throw DataError.createFailed(name: "Task")
            
        }
        
    }
    
    func deleteTask(with taskId: TaskId) async throws {
        
        do {
            
            await TaskUtility.shared.delay()
            
        } catch {
            throw DataError.deleteFailed(name: "Task")
        }
    }
    
    
}
