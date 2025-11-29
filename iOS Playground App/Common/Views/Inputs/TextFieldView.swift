//
//  TextFieldView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import SwiftUI


struct TextFieldView: View {
    
    var label: String = ""
    
    @Binding var text: String
    
    var errorMessage: String? = nil
    
    var onEditingChange: (_ isEditing: Bool) -> Void = { _ in }
    
    var body: some View {
        InputFiendWrapperView(errorMessage: errorMessage) {
            TextField(
                label,
                text: $text,
                onEditingChanged: onEditingChange
            )
            .modifier(FieldBackground())
        }
    }
}

#Preview {
    TextFieldView(
        text: .constant("")
    )
}
