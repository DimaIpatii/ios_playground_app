//
//  PasswordFieldView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import SwiftUI

struct PasswordFieldView: View {
    
    var label: String = "Password"
    
    @Binding var password: String
    
    var errorMessage: String? = nil
    
    var onEditingChange: (_ isEditing: Bool) -> Void = { _ in }
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        InputFiendWrapperView(errorMessage: errorMessage) {
            
            Group{
                
                if isPasswordVisible {
                    TextField(label, text: $password, onEditingChanged: onEditingChange)
                } else {
                    SecureField(label, text: $password, onCommit: {
                        onEditingChange(false)
                    })
                }

            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .padding(.trailing, 50)
            .modifier(PasswordFieldModifier())
            .overlay(alignment: .trailingLastTextBaseline) {
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.gray)
                    
                    
                }
                .frame(width: 48, height: 48)
            }
            
        }
    }
    
    private struct PasswordFieldModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .modifier(FieldBackground())
                
                
                
        }
    }
}


struct PasswordFieldPreviewView: View {
    
    @State var password: String = "Test123!"
    
    
    var body: some View {
        PasswordFieldView(password: $password)
    }
}
#Preview {
    PasswordFieldPreviewView()
        .padding()
}
