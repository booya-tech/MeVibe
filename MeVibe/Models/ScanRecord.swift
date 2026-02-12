//
//  ScanRecord.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/12/26.
//

import Foundation
import SwiftData

@Model // macro tells SwiftData "this is a database table"
class ScanRecord {
    var objectName: String
    var pointsEarned: Int
    var scannedAt: Date
    
    init(objectName: String, pointsEarned: Int) {
        self.objectName = objectName
        self.pointsEarned = pointsEarned
        self.scannedAt = Date()
    }
}
