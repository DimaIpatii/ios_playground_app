//
//  UserTasksCoordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine
import SwiftUI


extension UserTasksNavigationView {
        
    enum Destination: Hashable {
        case userTasks
    }
    
    enum SheetDestination: Identifiable {
        case editTask(task: UserTask)
        case createTask
        
            
        var id: String {
            switch self {
            case .createTask: return "createTask"
            case .editTask(task: _): return "editTask"
            }
        }
    
    }
    
    @MainActor
    final class UserTasksCoordinator: NSObject, Coordinator, ObservableObject {
        
        @Published var navigationPath: NavigationPath = NavigationPath()
        @Published var sheetDestination: SheetDestination? = nil
        
        
        
        func navgate(to destination: Destination) {
            navigationPath.append(destination)
        }
        
        func back() -> Void {
                
            guard self.navigationPath.count > 1 else { return }
            
            self.navigationPath.removeLast()
            
        }
        
        func openSheet(for destination: SheetDestination) -> Void {
            self.sheetDestination = destination
        }
            
        @ViewBuilder func view(for destination: Destination) -> some View {
            switch destination {
            case .userTasks:
                makeUserTasksView()
            }
        }
        
        private func makeUserTasksView() -> some View {
            let taskRepository = DIContainer.shared.getInstance(of: TasksRepository.self)
            //let userId = DIContainer.shared.getInstance(of: AuthenticationManager.self).userId!
            let userId = AppConstants.MOCK_USER_ID // TODO: Preview only!
            
            let viewModel = UserTasksView.ViewModel(userId: userId, tasksRepository: taskRepository)
            return UserTasksView(viewModel: viewModel)
            
        }
        
        @ViewBuilder func sheetView(for destination: SheetDestination) -> some View {
            switch destination {
            case .createTask:
                CreateUserTaskView()
            case .editTask(task: let task):
                EditUserTaskView(task: task)
            }
        }
    }

    
}
