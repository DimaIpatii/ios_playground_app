//
//  ListItemView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 14/11/25.
//

import SwiftUI

struct ListItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack{
            Text(label)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ListItemView(
        label: "Email",
        value: "test@email.com"
    )
}
