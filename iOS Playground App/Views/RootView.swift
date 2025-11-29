//
//  RootView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 25/10/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    RootView()
}
