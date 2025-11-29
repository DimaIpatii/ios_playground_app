//
//  InputFiendWrapperView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import SwiftUI

struct InputFiendWrapperView: View {
    
    var errorMessage: String? = nil
    
    @ViewBuilder var input: any View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
                        
            AnyView(input)
            
            if let errorMessage = errorMessage {
                InputErrorMessageView(errorMessage: errorMessage)
            }
        }
        
    }
    
}

#Preview {
    InputFiendWrapperView{
        TextField("Text", text: .constant(""))
            .modifier(FieldBackground())
    }
}
