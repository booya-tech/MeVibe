//
//  ShopViewModel.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ShopViewModel: ObservableObject {
    @Published var selectedCategory: ShopCategory = .plant
    @Published var showPurchaseAlert = false
    @Published var alertMessage = ""
    @Published var selectedItem: ShopItem?
    
    var dataManager: DataManager?
    
    var filteredItems: [ShopItem] {
        ShopCatalog.items(for: selectedCategory)
    }
    
    var totalPoints: Int {
        dataManager?.totalPoints ?? 0
    }
    
    func isPurchased(_ item: ShopItem) -> Bool {
        dataManager?.isPurchased(itemId: item.id) ?? false
    }
    
    func canAfford(_ item: ShopItem) -> Bool {
        totalPoints >= item.price
    }
    
    func attemptPurchase(_ item: ShopItem) {
        selectedItem = item
        
        if isPurchased(item) {
            alertMessage = AppStrings.attemptPurchaseIsPurchasedAlertMessage
            showPurchaseAlert = true
        } else if !canAfford(item) {
            alertMessage = "Not enough points! You need \(item.price - totalPoints) more."
            showPurchaseAlert = true
        } else {
            alertMessage = "Buy \(item.name) for \(item.price) points?"
            showPurchaseAlert = true
        }
    }
    
    func confirmPurchase() {
        guard let item = selectedItem else { return }
        
        if dataManager?.purchaseItem(item) == true {
            alertMessage = "\(AppStrings.confirmPurchaseSuccessAlertMessage) \(item.name)!"
            showPurchaseAlert = true
        } else {
            alertMessage = AppStrings.confirmPurchaseFailedAlertMessage
            showPurchaseAlert = true
        }
        
        selectedItem = nil
    }
}

