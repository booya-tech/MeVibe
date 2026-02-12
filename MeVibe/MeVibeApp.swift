//
//  MeVibeApp.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//

import SwiftUI
import SwiftData

@main
struct MeVibeApp: App {
    var body: some Scene {
        WindowGroup {
            ScannerView()
        }
        .modelContainer(for: [
            User.self,
            ScanRecord.self
        ])
    }
}
