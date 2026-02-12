//
//  DataManager.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/12/26.
//

import Foundation
import SwiftData
import Combine

@MainActor
class DataManager: ObservableObject {
    //MARK: - Properties
    private var modelContext: ModelContext
    @Published var currentUser: User?
    
    //MARK: - Initilization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadOrCreateUser()
    }
    
    //MARK: - Computed Properties
    // Get Total Points
    var totalPoints: Int {
        currentUser?.totalPoints ?? 0
    }
    
    // Get Recent Scans(Future Uses)
    var recentScans: [ScanRecord] {
        currentUser?.scanHistory.sorted { $0.scannedAt > $1.scannedAt } ?? []
    }
    
    //MARK: - Methods
    func loadOrCreateUser() {
        let descriptor = FetchDescriptor<User>()
        
        do {
            // Get current user
            let users = try modelContext.fetch(descriptor)
            if let existingUser = users.first {
                currentUser = existingUser
            } else {
                // Create a new user(first time opening the app)
                let newUser = User(totalPoints: 0)
                modelContext.insert(newUser)
                try modelContext.save()
                
                currentUser = newUser
            }
        } catch {
            print("Failed to load user: \(error)")
        }
    }
    
    func addPoints(_ points: Int, for objectName: String) {
        // Check current user
        guard let user = currentUser else { return }
        
        // Update total points
        user.totalPoints += points
        
        // Create scan record
        let record = ScanRecord(objectName: objectName, pointsEarned: points)
        user.scanHistory.append(record)
        
        // Save to database
        do {
            try modelContext.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
}
