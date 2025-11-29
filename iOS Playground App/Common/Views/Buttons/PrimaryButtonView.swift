//
//  PrimaryButtonView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 24/11/25.
//

import SwiftUI

struct PrimaryButtonView: View {
    
    let title: String
    var buttonStyle: BaseButtonView.ButtonStyleType = .borderedProminent
    var isLoading: Bool = false
    var isDisabled: Bool = false
    var onPress: () -> Void
    
    var body: some View {
        BaseButtonView(
            title: title,
            buttonStyle: buttonStyle,
            isDisabled: isDisabled,
            isLoading: isLoading,
            onPress: onPress
        )
        
    }
}

#Preview {
    PrimaryButtonView(
        title: "Action",
        isDisabled: true,
        onPress: {}
    )
        
}
