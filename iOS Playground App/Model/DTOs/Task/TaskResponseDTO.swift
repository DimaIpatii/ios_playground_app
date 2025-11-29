//
//  TaskResponseDTO.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 22/11/25.
//

import Foundation

struct TaskResponseDTO: Codable {
    let todos: Array<TaskDTO>
    let total: Int
    let skip: Int
    let limit: Int
}
