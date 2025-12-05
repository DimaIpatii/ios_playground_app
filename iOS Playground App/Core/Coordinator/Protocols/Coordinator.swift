//
//  Coordinator.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 29/11/25.
//

import Foundation
import SwiftUI

protocol Coordinator: AnyObject {
    var navigationPath: NavigationPath { get set }
        
}
