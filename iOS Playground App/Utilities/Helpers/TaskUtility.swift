//
//  TaskUtility.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation


final class TaskUtility {
    
    static let shared = TaskUtility()
    
    private init() {}
    
    func delay(for delay: TimeInterval, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
    }
    
    func delay() async {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
    }
}
