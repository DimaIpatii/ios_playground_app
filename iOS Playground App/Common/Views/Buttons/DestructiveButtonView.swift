//
//  DestructiveButtonView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 24/11/25.
//

import SwiftUI

struct DestructiveButtonView: View {
    
    let title: String
    var isDisabled: Bool = false
    var isLoading: Bool = false
    var onPress: () -> Void
    
    var body: some View {
        BaseButtonView(
            title: title,
            role: .destructive,
            buttonStyle: .bordered,
            isDisabled: isDisabled,
            isLoading: isLoading,
            onPress: onPress
        )
    }
}

#Preview {
    DestructiveButtonView(
        title: "Action", onPress: {}
    )
}
