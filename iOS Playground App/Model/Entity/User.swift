//
//  User.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation


struct User: Identifiable, Hashable {
    let id: UserId
    let name: String
    let email: String
}
