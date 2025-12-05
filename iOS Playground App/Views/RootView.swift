//
//  RootView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 25/10/25.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var rootCoordinator: RootCoordinator

    init() {
         
        let authenticationManager = DIContainer.shared.getInstance(of: AuthenticationManager.self)
        
        self._rootCoordinator = StateObject(wrappedValue: RootCoordinator(
            authenticationManager: authenticationManager
        ))
    }
    
    var body: some View {
        
        if rootCoordinator.isAuthenticated {
            MainNavigationView()
                .environmentObject(rootCoordinator)
        } else {
            AuthenticationNavigationView()
                .environmentObject(rootCoordinator)
        }
              
    }
}

#Preview {
    RootView()
}
