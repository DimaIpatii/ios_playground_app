//
//  AuthenticationView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import SwiftUI

struct AuthenticationNavigationView: View {
    
    @StateObject var authenticationCoordinator: AuthenticationCoordinator = AuthenticationCoordinator()
    
    var body: some View {
        NavigationStack(path: $authenticationCoordinator.navigationPath) {
            
            authenticationCoordinator.view(for: .signIn)
                .navigationDestination(for: Destination.self, destination: authenticationCoordinator.view(for:))
            
        }
        .sheet(item: $authenticationCoordinator.sheetDestination, content: authenticationCoordinator.sheetView(for:))
        .environmentObject(authenticationCoordinator)
    }
}

#Preview {
    AuthenticationNavigationView()
}
