//
//  View+Extensions.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 21/11/25.
//

import Foundation
import SwiftUI

extension View {
    
    func alertDialog(
        title: String,
        message: String? = nil,
        isPresnted: Binding<Bool>,
        confirmActionLabel: String = "Ok",
        confirmActionRole: ButtonRole? = nil,
        confirmAction: @escaping () -> Void,
        dismissActionLabel: String? = nil,
        dismissActionRole: ButtonRole = .cancel,
        dismissAction: @escaping () -> Void = {}
        
    ) -> some View {
        alert(
            title,
            isPresented: isPresnted,
            actions: {

                Button(role: confirmActionRole) {
                    confirmAction()
                } label: {
                    Text(confirmActionLabel)
                }
                
                if let dismissActionLabel {
                    Button(role: dismissActionRole) {
                        dismissAction()
                    } label: {
                        Text(dismissActionLabel)
                    }
                }
                
                
                
            },
            message: {
                if let message = message {
                    Text(message)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        )
    }
}
