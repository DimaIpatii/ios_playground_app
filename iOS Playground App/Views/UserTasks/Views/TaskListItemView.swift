//
//  TaskListItemView.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 26/11/25.
//

import SwiftUI

struct TaskListItemView: View {

    let task: Binding<UserTask>
    var isDisabled: Bool = false
    var isCompleting: Bool = false
    
    var onPress: (_ task: UserTask) -> Void
    var onComplete: (_ isCompleted: Bool) -> Void
    
    @State private var isCompleted: Bool = false
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            HStack(){
                Text(task.wrappedValue.title)
                    .font(.headline)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
                onPress(task.wrappedValue)
            }

            if isCompleting {
                
                VStack{
                    ProgressView()
                }
                .frame(width: 50)

            } else {
                
                
                Toggle(
                    "",
                    isOn: Binding(get: {
                        task.wrappedValue.completed
                    }, set: { completedValue in
                        
                        if task.wrappedValue.completed != completedValue {
                            onComplete(completedValue)
                        }
                        
                    })
                )
                
                .labelsHidden()
                .disabled(isDisabled)
                
            }
            
        }
//        .onChange(of: task.wrappedValue) { oldValue, newValue in
//            self.isCompleted = newValue.completed
//        }
//        .onChange(of: isCompleted, { oldValue, newValue in
//            
//            guard task.wrappedValue.completed != newValue else { return }
//            
//            onComplete(isCompleted)
//            
//        })
//        .onAppear {
//            self.isCompleted = task.wrappedValue.completed
//        }
        
    }
}

#Preview {

    VStack{
        TaskListItemView(
            task: .constant(UserTask.testModel),
            isCompleting: false,
            onPress: { task in},
            onComplete: { isCompleted in }
        )
    }

}
