//
//  UserProfileCoordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine
import SwiftUI


extension UserProfileNavigationView {
    
    enum Destination: Hashable {
        case userProfile
    }
    
    enum SheetDestination: Identifiable {
        case editUserProfile(User)
        
        var id: String {
            switch self {
            case .editUserProfile(_): return "editUserProfile"
            }
        }
    }
    
    @MainActor
    final class UserProfileCoordinator: NSObject, Coordinator, ObservableObject {
        
        @Published var navigationPath: NavigationPath = NavigationPath()
        @Published var sheetDestination: SheetDestination? = nil
        
        func navigate(to destination: Destination) -> Void {
            self.navigationPath.append(destination)
        }
        
        func back() -> Void {
            
            guard self.navigationPath.count > 1 else {return }
            
            self.navigationPath.removeLast()
        }
        
        @ViewBuilder func view(for destination: Destination) -> some View {
            switch destination {
            case .userProfile:
                makeUserProfileView()
            }
        }
        
        private func makeUserProfileView() -> some View {
            let userRespository = DIContainer.shared.getInstance(of: UserRepository.self)
            
            let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)

            let viewModel = UserProfileView.ViewModel(
                userRepository: userRespository,
                authenticationRepository: authenticationRepository
            )
            
            return UserProfileView(viewModel: viewModel)
        }
        
        func openSheet(for destination: SheetDestination) -> Void {
            self.sheetDestination = destination
        }
        
        @ViewBuilder func sheetView(for destination: SheetDestination) -> some View {
            switch destination {
            case .editUserProfile(let user):
                EditUserProfileView(user: user)
            }
        }
        
    }

}
