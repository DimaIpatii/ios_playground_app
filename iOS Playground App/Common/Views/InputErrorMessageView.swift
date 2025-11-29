//
//  ErrorMessageView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import SwiftUI

struct InputErrorMessageView: View {
    
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .font(.footnote)
            .foregroundStyle(.red)
            .transition(.opacity)
    }
}

#Preview {
    InputErrorMessageView(errorMessage: "Some error message")
}
