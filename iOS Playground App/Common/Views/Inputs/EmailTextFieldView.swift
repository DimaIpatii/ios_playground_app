//
//  EmailTextFieldView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import SwiftUI

struct EmailTextFieldView: View {
    
    var label: String = "Email"
    
    @Binding var email: String
    
    var errorMessage: String? = nil
    
    var onEditingChanged: (_ isEditing: Bool) -> Void = { _ in }
    
    var body: some View {
        
        InputFiendWrapperView(errorMessage: errorMessage) {
            
            TextField(
                label,
                text: $email,
                onEditingChanged: onEditingChanged
            )
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .modifier(FieldBackground())
                
        }
        
    }
}




struct EmailTextFieldWrapperView: View {
    @State var email: String = ""
    
    var body: some View {
        EmailTextFieldView(
            email: $email
            
        )
        
    }
}
#Preview {
    EmailTextFieldWrapperView()
        .padding()
}
