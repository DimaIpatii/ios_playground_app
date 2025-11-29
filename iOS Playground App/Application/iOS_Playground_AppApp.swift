//
//  iOS_Playground_AppApp.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 25/10/25.
//

import SwiftUI

@main
struct iOS_Playground_AppApp: App {
    
    init(){
        DIContainer.setUpDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
