//
//  AppError.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 17/11/25.
//

import Foundation


// MARK: Base App Error Protocol
protocol AppError: LocalizedError {
    var title: String {get}
    var message: String {get}
    var code: Int {get}
}
