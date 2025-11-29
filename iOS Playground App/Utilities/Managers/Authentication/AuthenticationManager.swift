//
//  AuthenticationManager.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 08/11/25.
//

import Foundation
import Combine

final class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
}
