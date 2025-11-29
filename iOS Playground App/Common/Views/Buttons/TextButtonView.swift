//
//  TextButtonView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 24/11/25.
//

import SwiftUI

struct TextButtonView: View {
    
    let title: String
    var isDisabled: Bool = false
    var isLoading: Bool = false
    let onPress: () -> Void
    
    var body: some View {
        BaseButtonView(
            title: title,
            isDisabled: isDisabled,
            isLoading: isLoading,
            onPress: onPress
        )
    }
}

#Preview {
    TextButtonView(
        title: "Action",
        onPress: {}
    )
}
