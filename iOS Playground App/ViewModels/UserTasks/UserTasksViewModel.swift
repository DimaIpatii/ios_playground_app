//
//  UserTasksViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation
import Combine
import SwiftUI

extension UserTasksView {
    
    enum Filter: String, CaseIterable, Identifiable {
        case all
        case completed
        case notCompleted
        
        var id: Self {
            return self
        }
        
        var title: String {
            switch self {
            case .all: return "All"
            case .completed: return "Completed"
            case .notCompleted: return "Not completed"
            }
        }
    }
    
    @MainActor
    final class ViewModel: ObservableObject {

        private let userId: UserId
        private let tasksRepository: TasksRepository
        
        private var cancellables =  Set<AnyCancellable>()
        
        @Published var isRefreshingTasks: Bool = false
        @Published var isFetchingTasks: Bool = false
        @Published var updatingTaskIds: Set<TaskId> = []
        @Published var isDeleting: Bool = false
        

        @Published var searchQuery: String = ""
        @Published var selectedFilter: Filter = .all {
            didSet {
                self.applyFilters()
            }
        }
        
        private var tasks: [UserTask] = [] {
            didSet {
                self.applyFilters()
            }
        }
        
        @Published var filteredTasks: [UserTask] = []

        // Error Messages
        @Published var showErrorAlert: Bool = false
        @Published var errorTitile: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String? = nil
        
        init(
            userId: UserId,
            tasksRepository: TasksRepository
        ) {
            self.userId = userId
            self.tasksRepository = tasksRepository
            self.publisherRegister()
        }
        
        deinit{
            cancellables.removeAll()
        }
        
        private func publisherRegister() {
            
            self.registerSearchQueryObserver()
            
        }
        
        private func registerSearchQueryObserver() {
                
            $searchQuery
                .dropFirst()
                .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                .sink { _ in
                    self.applyFilters()
                }
                .store(in: &cancellables)
            
        }
        
        private func applyFilters() -> Void {
         
            let filteredTasksBySearchQuery = self.filterTasksBySearchQuery(searchQuery: self.searchQuery)
            
            let filteredTasksByCompletedStatus = self.filterTasksByCompletedStatus(tasks: filteredTasksBySearchQuery)
            
            self.filteredTasks = filteredTasksByCompletedStatus
        }
        
        private func filterTasksBySearchQuery(searchQuery: String) -> [UserTask] {
            
            guard self.searchQuery.trim().isEmpty == false else {
                return self.tasks
            }
            
            return self.tasks.filter({$0.title.lowercased().contains(searchQuery.lowercased())})
            
        }
        
        private func filterTasksByCompletedStatus(tasks: [UserTask]) -> [UserTask] {
            
            guard self.selectedFilter != .all else {
                return tasks
            }
            
            return tasks.filter({ task in
                
                let isCompleted = self.selectedFilter == .completed
                
                return task.completed == isCompleted
            })
        }
        
        
        func initializeTasks() async -> Void {

            do {
                self.isFetchingTasks = true

                try await self.fetchTasks()
                
                self.isFetchingTasks = false
                
            } catch {
                
                self.isFetchingTasks = false
                
                showUnexpectedErrorMessage()
                
            }
            
        }
        
        func refreshTasks() async -> Void {
            
            do {
                
                self.isRefreshingTasks = true
                
                try await self.fetchTasks()
                
                self.isRefreshingTasks = false
                
            } catch {
                
                self.isRefreshingTasks = false
                
            }
            
            
        }
        
        private func fetchTasks() async throws -> Void {
            
            do {

                let tasksResponse = try await self.tasksRepository.getAllTasks(by: self.userId)
                
                self.tasks = Array(tasksResponse)

                
            } catch let error as DataError {
                
                self.showErrorMessage(error)
                
            } catch {

                self.showUnexpectedErrorMessage()
                
            }
                
        }
        
        func updateStatusCompleted(_ isCompleted: Bool, for task: UserTask, ) -> Void {
            
            Task {
                do {
                    
                    self.updatingTaskIds.insert(task.id)
                    
                    let updatedTaskToSave = task.copyWith(completed: isCompleted)
                    
                    self.updateTaskIsCompleted(with: isCompleted, for: task)
                    
                    let _ = try await self.tasksRepository.updateTask(for: task.id, data: updatedTaskToSave)
                    
                    self.updatingTaskIds.remove(task.id)
                    
                } catch let error as DataError {
                    
                    self.updatingTaskIds.remove(task.id)
                    self.showErrorMessage(error)
                    
                    await self.refreshTasks()
                    
                    
                } catch {
                    
                    self.updatingTaskIds.remove(task.id)
                    self.showUnexpectedErrorMessage()
                    
                    await self.refreshTasks()
                    
                }
            }
            
        }
        
        private func updateTaskIsCompleted(with isCompleted: Bool, for task: UserTask ) -> Void {
            self.tasks = self.tasks.map({ userTask in
                
                if userTask.id == task.id {
                    return task.copyWith(completed: isCompleted)
                }
                
                return userTask
            })
        }
        
        func deleteTask(_ indexSet: IndexSet) -> Void {
            
            Task {
                
                do {
                    
                    self.isDeleting = true
                    
                    guard let index = indexSet.first, self.tasks.indices.contains(index) else {
                        throw DataError.notFound
                    }
                    
                    let task = self.tasks[index]
                    
                    try await self.tasksRepository.deleteTask(with: task.id)

                    
                    withAnimation {
                        self.tasks.remove(atOffsets: indexSet)
                    }
                    
                    self.isDeleting = false
                    
                } catch let error as DataError {
                    
                    self.isDeleting = false
                    
                    self.showErrorMessage(error)
                    
                } catch {
                    
                    self.isDeleting = false
                    
                    self.showUnexpectedErrorMessage()
                    
                }
            }
            
        }
        
        func hideErrorMessage() -> Void {
            self.showErrorAlert = false
            self.errorTitile = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = nil
        }
        
        private func showErrorMessage(_ error: AppError) -> Void {
            
            self.errorTitile = error.title
            self.errorMessage = error.message
            self.showErrorAlert = true
            
        }
        
        private func showUnexpectedErrorMessage() -> Void {
            
            self.errorTitile = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = "An unexpected error occured. Please try again later."
            self.showErrorAlert = true
            
        }

    }
    
}
