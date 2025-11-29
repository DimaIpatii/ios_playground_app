//
//  CreateTaskRequestDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 28/11/25.
//

import Foundation

struct CreateTaskRequestDTO: Codable {
    let todo: String
    var completed: Bool = false
}
