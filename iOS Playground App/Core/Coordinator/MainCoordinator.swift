//
//  MainCoordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine
import SwiftUI

extension MainNavigationView {
   
    enum Destination: Hashable, CaseIterable, Identifiable {
        case userTasks
        case userProfile
        
        var id: String {
            switch self {
            case .userProfile: "userProfile"
            case .userTasks: "userTasks"
            }
        }
        var title: String {
            switch self {
                case .userProfile: "Profile"
                case .userTasks: "Tasks"
            }
        }
        
        var icon: String {
            switch self {
                case .userProfile: "person"
                case .userTasks: "checklist"
            }
        
        }

    }
    
    @MainActor
    final class MainCoordinator: NSObject, ObservableObject {
        
        @Published var navigationPath: Destination = .userTasks
        @Published var tabDestinations: [Destination] = Destination.allCases
        
        func navigate(to destination: Destination) -> Void {
            navigationPath = destination
        }
        
        @ViewBuilder func view(for destination: Destination) -> some View {
            switch destination {
            case .userTasks:
                makeUserTasksView()
            case .userProfile:
                makeUserProfileView()
            }
        }
        
        private func makeUserTasksView() -> some View {
            
            return UserTasksNavigationView()
        }
        
        private func makeUserProfileView() -> some View {
            
            return UserProfileNavigationView()
        }
            
    }



    
}
