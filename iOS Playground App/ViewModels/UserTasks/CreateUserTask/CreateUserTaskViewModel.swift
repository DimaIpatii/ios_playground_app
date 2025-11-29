//
//  CreateUserTaskViewModel.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine

extension CreateUserTaskView {
    
    @MainActor
    final class ViewModel: ObservableObject {
        
        private let userId: UserId
        private let tasksRepository: TasksRepository
        
        @Published var title: String = "" {
            didSet {
                self.isSavingButtonDisabled = title.trim().isEmpty
            }
        }
        
        // Form States
        @Published var isSaving: Bool = false
        @Published var isSavingButtonDisabled: Bool = true
        
        // Error Messages
        @Published var showErrorAlert: Bool = false
        @Published var errorTitle: String = AppConstants.ERROR_TITLE_PLACEHOLDER
        @Published var errorMessage: String? = nil
        
        
        init(userId: UserId, tasksRepository: TasksRepository) {
            self.userId = userId
            self.tasksRepository = tasksRepository
        }
        
        func submit(onSuccess: @escaping (_ createdTask: UserTask) -> Void ) -> Void {
            
            Task{
                do {
                    
                    self.isSaving = true
                    
                    let newTask = try await self.tasksRepository.createTask(for: self.userId, title: self.title)
                    
                    onSuccess(newTask)
                    
                    self.isSaving = false
                    
                } catch let error as DataError {
                    
                    self.isSaving = false
                    
                    self.showErrorMessage(error)
                    
                } catch {
                    
                    self.isSaving = false
                    
                    self.showUnhandledError()
                    
                }
            }
            
        }
        
        func hideErrorMessage() -> Void {
            
            self.showErrorAlert = false
            self.errorTitle = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = nil
            
        }
        
        private func showErrorMessage(_ error: AppError) -> Void {
            
            self.errorTitle = error.title
            self.errorMessage = error.message
            self.showErrorAlert = true
            
        }
        
        private func showUnhandledError() -> Void {
            
            self.errorTitle = AppConstants.ERROR_TITLE_PLACEHOLDER
            self.errorMessage = "Unexpected error occurred."
            self.showErrorAlert = true
            
        }
        
    }
    
}
