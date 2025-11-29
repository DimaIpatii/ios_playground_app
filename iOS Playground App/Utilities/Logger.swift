//
//  Logger.swift
//  iOS Playground App
//
//  Created by Dmytro Ipatii on 17/11/25.
//

import Foundation
import OSLog

final class Logger {
    
    static let shared = Logger()
    
    static let subsystem: String = Bundle.main.bundleIdentifier ?? "UKNOWN_BUNDLE_IDENTIFIER"
    
    private let logger = OSLog(subsystem: Logger.subsystem, category: "General")
    
    private init() {}
    
    static func initialize() {
        
        // Initializer for services user in Logger such as Analytics, Crashlytics.
        
    }
    
    static func info(message: String) -> Void {
        
        os_log("%{public}@", log: Logger.shared.logger, type: .info, "ℹ️ Info: \(message)")
        
    }
    
    static func warning(message: String) -> Void {
        
        os_log("%{public}@", log: Logger.shared.logger, type: .default, "⚠️ Warning: \(message)")
        
    }
    
    static func error(message: String) -> Void {
        
        os_log("%{public}@", log: Logger.shared.logger, type: .error, "❌ Error: \(message)")
        
    }
    
    static func critical(message: String) -> Void {
        
        os_log("%{public}@", log: Logger.shared.logger, type: .fault, "⛔️ Critical: \(message)")
        
    }
    
    static func debug(message: String) -> Void {
            
        #if DEBUG
        os_log("%{pubic}@", log: Logger.shared.logger, type: .debug, "DEBUG: \(message)")
        #endif
        
    }
    
}

