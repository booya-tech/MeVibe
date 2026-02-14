//
//  MainTabView.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var dataManager: DataManager
    
    init() {
        let context = ModelContext(ModelContainer.shared)
        _dataManager = StateObject(wrappedValue: DataManager(modelContext: context))
    }
    
    var body: some View {
        TabView {
            ScannerView(dataManager: dataManager)
                .tabItem {
                    Label("Scan", systemImage: "camera.fill")
                }
            
            ShopView(dataManager: dataManager)
                .tabItem {
                    Label("Shop", systemImage: "cart.fill")
                }
        }
        .onAppear {
            // Pass dataManager to scanner if needed
        }
    }
}

