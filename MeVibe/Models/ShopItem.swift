//
//  ShopItem.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import Foundation

struct ShopItem: Identifiable {
    let id: String
    let name: String
    let price: Int
    let imageName: String  // For future 3D models (e.g., "sunflower_model")
    let emoji: String      // Placeholder for now
    let category: ShopCategory
    let description: String
}

enum ShopCategory: String, CaseIterable {
    case plant = "Plants"
    case decoration = "Decorations"
}

// Static Catalog
struct ShopCatalog {
    static let allItems: [ShopItem] = [
        // PLANTS (5 items)
        ShopItem(
            id: "plant_sunflower",
            name: "Sunflower",
            price: 30,
            imageName: "sunflower_model",
            emoji: "🌻",
            category: .plant,
            description: "Bright and cheerful"
        ),
        ShopItem(
            id: "plant_rose",
            name: "Rose",
            price: 50,
            imageName: "rose_model",
            emoji: "🌹",
            category: .plant,
            description: "Classic beauty"
        ),
        ShopItem(
            id: "plant_cactus",
            name: "Cactus",
            price: 20,
            imageName: "cactus_model",
            emoji: "🌵",
            category: .plant,
            description: "Low maintenance"
        ),
        ShopItem(
            id: "plant_bonsai",
            name: "Bonsai Tree",
            price: 80,
            imageName: "bonsai_model",
            emoji: "🌳",
            category: .plant,
            description: "Zen and peaceful"
        ),
        ShopItem(
            id: "plant_tulip",
            name: "Tulip",
            price: 35,
            imageName: "tulip_model",
            emoji: "🌷",
            category: .plant,
            description: "Spring vibes"
        ),
        
        // DECORATIONS (5 items)
        ShopItem(
            id: "deco_gnome",
            name: "Garden Gnome",
            price: 25,
            imageName: "gnome_model",
            emoji: "🧙‍♂️",
            category: .decoration,
            description: "Protects your garden"
        ),
        ShopItem(
            id: "deco_fountain",
            name: "Fountain",
            price: 60,
            imageName: "fountain_model",
            emoji: "⛲",
            category: .decoration,
            description: "Soothing water sounds"
        ),
        ShopItem(
            id: "deco_bench",
            name: "Garden Bench",
            price: 40,
            imageName: "bench_model",
            emoji: "🪑",
            category: .decoration,
            description: "Place to rest"
        ),
        ShopItem(
            id: "deco_lantern",
            name: "Lantern",
            price: 30,
            imageName: "lantern_model",
            emoji: "🏮",
            category: .decoration,
            description: "Lights up the night"
        ),
        ShopItem(
            id: "deco_statue",
            name: "Stone Statue",
            price: 70,
            imageName: "statue_model",
            emoji: "🗿",
            category: .decoration,
            description: "Ancient mystery"
        )
    ]
    
    // Helper methods
    static func items(for category: ShopCategory) -> [ShopItem] {
        allItems.filter { $0.category == category }
    }
    
    static func item(withId id: String) -> ShopItem? {
        allItems.first { $0.id == id }
    }
}

