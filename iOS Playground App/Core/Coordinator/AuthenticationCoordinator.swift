//
//  AuthenticationCoordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import Combine
import SwiftUI


extension AuthenticationNavigationView {
    enum Destination: Hashable {
        case signIn
        case signUp
    }
    
    enum SheetDestination: Identifiable {
        case forgetPassword
        
        var id: String {
            switch self {
            case .forgetPassword: return "forgetPassword"
            }
        }
    }
    
    @MainActor
    final class AuthenticationCoordinator: ObservableObject, Coordinator {
        
        @Published var navigationPath: NavigationPath = NavigationPath()
        @Published var sheetDestination: SheetDestination? = nil
        
        func navigate(to destination: Destination) {
            navigationPath.append(destination)
        }
        
        func back() {
            
            guard self.navigationPath.isEmpty == false else { return }
            
            self.navigationPath.removeLast()
            
        }
        
        func openSheet(for destination: SheetDestination) -> Void {
            self.sheetDestination = destination
        }
        
        @ViewBuilder func view(for destination: Destination) -> some View {
            
            switch destination {
            case .signIn:
                makeSignInView()
            case .signUp:
                makeSignUpView()
            }
            
        }
        
        private func makeSignInView() -> some View {
            
            let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
            
            let viewModel = SignInView.ViewModel(
                repository: authenticationRepository
            )
            
            return SignInView(viewModel: viewModel)
        }
        
        private func makeSignUpView() -> some View {
            let authRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
            
            let viewModel = SignUpView.ViewModel(repository: authRepository)
            
            return SignUpView(viewModel: viewModel)
        }
        
        @ViewBuilder func sheetView(for destination: SheetDestination) -> some View {
            switch destination {
            case .forgetPassword:
                makePasswordResetView()
            }
        }
        
        private func makePasswordResetView() -> some View {
            let authenticationRepository = DIContainer.shared.getInstance(of: AuthenticationRepository.self)
            
            let viewModel = PasswordResetView.ViewModel(repository: authenticationRepository)
            return PasswordResetView(viewModel: viewModel)
        }
        
    }
}
