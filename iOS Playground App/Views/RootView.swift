//
//  RootView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 25/10/25.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var authenticationManager: AuthenticationManager
    
    init() {
        self._authenticationManager = StateObject(wrappedValue: DIContainer.shared.getInstance(of: AuthenticationManager.self))
    }
    
    var body: some View {
        
        if authenticationManager.isAuthenticated {
            //UserProfileView()
            UserTasksView()
        } else {
            SignInView()
        }
              
    }
}

#Preview {
    RootView()
}
