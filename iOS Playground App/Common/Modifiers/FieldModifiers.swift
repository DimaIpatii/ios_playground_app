//
//  TextFieldModifiers.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import Foundation
import SwiftUI

struct TextFieldBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
