//
//  BaseButtonView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 24/11/25.
//

import SwiftUI


struct BaseButtonView: View {
    
    let title: String
    var role: ButtonRole? = nil
    var buttonStyle: ButtonStyleType = .borderless
    var isDisabled: Bool = false
    var isLoading: Bool = false
    let onPress: () -> Void
        
    enum ButtonStyleType {
        case borderless
        case borderedProminent
        case bordered
    }
    
    private var isActionDisabled: Bool {
        isDisabled || isLoading
    }
    
    var body: some View {
        Button(
            role: role,
            action: onPress,
            label: {
                HStack{
                    
                    if isLoading {
                        ProgressView()
                    }
                    
                    Text(title)
                    
                }
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                
                
            },
        )
        .disabled(isActionDisabled)
        .getButtonStyle(buttonStyle)
        
    }
}


private extension View  {
    func getButtonStyle(_ type: BaseButtonView.ButtonStyleType) -> some View {
        
        switch type {
        case .borderless:
            return AnyView(self.buttonStyle(.borderless))
        case .borderedProminent:
            return AnyView(self.buttonStyle(.borderedProminent))
        case .bordered:
            return AnyView(self.buttonStyle(.bordered))
        }
                
    }
}

#Preview {
    VStack{
        BaseButtonView(
            title: "Action",
            buttonStyle: .borderedProminent,
            onPress: {}
        )
        
        
        
    }
    
}
