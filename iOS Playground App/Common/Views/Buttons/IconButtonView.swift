//
//  IconButtonView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 24/11/25.
//

import SwiftUI

struct IconButtonView: View {
    
    let icon: String
    var isDisabled: Bool = false
    var isLoading: Bool = false
    let onPress: () -> Void
    
    private var isActionDisabeld: Bool {
        return isDisabled || isLoading
    }
    
    var body: some View {
        Button(
            action: onPress,
            label: {

                if isLoading {
                    ProgressView()
                } else {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        //.frame(width: 30, height: 30)
                }
                 
            }
        )
        .frame(maxWidth: 44, maxHeight: 44)
        
        .disabled(isActionDisabeld)
    }
}

#Preview {
    IconButtonView(
        icon: "paperplane",
        onPress: {}
    )
}
