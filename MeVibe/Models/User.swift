//
//  User.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/12/26.
//

import Foundation
import SwiftData

@Model
class User {
    var totalPoints: Int
    var createdAt: Date
    
    // Relationship: One user has many scan records
    @Relationship(deleteRule: .cascade)
    var scanHistory: [ScanRecord] = []
    
    init(totalPoints: Int = 0) {
        self.totalPoints = totalPoints
        self.createdAt = Date()
    }
}
