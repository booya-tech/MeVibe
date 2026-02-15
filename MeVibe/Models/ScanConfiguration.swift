//
//  ScanConfiguration.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/15/26.
//

import Foundation

struct ScanConfiguration {
    // MARK: - Easy Configuration for Testing
    
    /// Minimum confidence required (0.0 to 1.0)
    static let minimumConfidence: Float = 0.6
    
    /// Number of consecutive frames needed for stable detection
    static let stabilityFrameCount: Int = 45 // 1.5 seconds at 30fps
    
    /// Cooldown period in seconds (change this for testing)
    static let cooldownSeconds: TimeInterval = 30 * 60 // 30 minutes
    // For testing, use: static let cooldownSeconds: TimeInterval = 10 // 10 seconds
    
    /// Show confidence percentage (debug mode)
    static let showConfidence: Bool = true
}

// MARK: - Cooldown Manager
class CooldownManager {
    private var lastScanTimes: [String: Date] = [:] // objectName -> lastScanDate
    
    func canScan(objectName: String) -> Bool {
        guard let lastScan = lastScanTimes[objectName] else {
            return true // Never scanned before
        }
        
        let timeSinceLastScan = Date().timeIntervalSince(lastScan)
        return timeSinceLastScan >= ScanConfiguration.cooldownSeconds
    }
    
    func recordScan(objectName: String) {
        lastScanTimes[objectName] = Date()
    }
    
    func timeUntilAvailable(objectName: String) -> TimeInterval? {
        guard let lastScan = lastScanTimes[objectName] else {
            return nil
        }
        
        let timeSinceLastScan = Date().timeIntervalSince(lastScan)
        let remaining = ScanConfiguration.cooldownSeconds - timeSinceLastScan
        return remaining > 0 ? remaining : nil
    }
    
    func formattedTimeRemaining(objectName: String) -> String? {
        guard let remaining = timeUntilAvailable(objectName: objectName) else {
            return nil
        }
        
        let hours = Int(remaining) / 3600
        let minutes = Int(remaining) / 60 % 60
        let seconds = Int(remaining) % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m \(seconds)s"
        } else {
            return "\(seconds)s"
        }
    }
}

