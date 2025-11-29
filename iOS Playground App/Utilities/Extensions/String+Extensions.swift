//
//  String+Extensions.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 15/11/25.
//

import Foundation


extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
}
