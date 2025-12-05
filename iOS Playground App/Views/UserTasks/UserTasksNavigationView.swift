//
//  UserTasksNavigationView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 05/12/25.
//

import SwiftUI

struct UserTasksNavigationView: View {
    @StateObject private var userTasksCoordinator: UserTasksCoordinator = UserTasksCoordinator()
    
    var body: some View {
        NavigationStack(path: $userTasksCoordinator.navigationPath, root: {
            
            userTasksCoordinator.view(for: .userTasks)
                .navigationDestination(for: Destination.self, destination: userTasksCoordinator.view(for:))
            
        })
        .sheet(item: $userTasksCoordinator.sheetDestination, content: { destination in
            userTasksCoordinator.sheetView(for: destination)
        })
        .environmentObject(userTasksCoordinator)
    }
}

#Preview {
    UserTasksNavigationView()
}
