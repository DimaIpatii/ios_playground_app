//
//  UserProfileNavigationView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 03/12/25.
//

import SwiftUI

struct UserProfileNavigationView: View {
    
    @StateObject private var userProfileCoordinator: UserProfileCoordinator = UserProfileCoordinator()
    
    var body: some View {
        NavigationStack(path: $userProfileCoordinator.navigationPath) {
           
            userProfileCoordinator.view(for: .userProfile)
                .navigationDestination(for: Destination.self, destination: userProfileCoordinator.view(for:))
        }
        .sheet(item: $userProfileCoordinator.sheetDestination, content: { destination in
            userProfileCoordinator.sheetView(for: destination)
        })
        .environmentObject(userProfileCoordinator)
    }
}

#Preview {
    UserProfileNavigationView()
}
