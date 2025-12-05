//
//  Main.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import SwiftUI

struct MainNavigationView: View {
    
    @StateObject var mainCoordinator: MainCoordinator = MainCoordinator()
    
    var body: some View {
        TabView(selection: $mainCoordinator.navigationPath) {
            
            ForEach(mainCoordinator.tabDestinations) { destination in
                
                Tab(
                    destination.title,
                    systemImage: destination.icon,
                    value: destination
                ){
                    mainCoordinator.view(for: destination)
                }
                    
            }
        }
    }
}

#Preview {
    MainNavigationView()
}
