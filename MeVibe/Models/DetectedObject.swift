//
//  DetectedObject.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/11/26.
//

import Foundation

struct ValuableObject {
    let name: String
    let points: Int
    let keywords: [String]
}

struct ObjectDatabase {
    static let valuableObjects: [ValuableObject] = [
            ValuableObject(
                name: "Plant",
                points: 20,
                keywords: ["plant", "potted_plant", "vase", "flower", "succulent", "cactus"]
            ),
            ValuableObject(
                name: "Book",
                points: 15,
                keywords: ["book", "notebook", "bookcase", "library"]
            ),
            ValuableObject(
                name: "Coffee",
                points: 10,
                keywords: ["coffee", "cup", "mug", "espresso", "latte"]
            ),
            ValuableObject(
                name: "Laptop",
                points: 5,
                keywords: ["laptop", "computer", "notebook", "macbook"]
            )
        ]
        
    // Check if a detected label matches any valuable object
    static func findMatch(for label: String) -> ValuableObject? {
        let lowercasedLabel = label.lowercased()
        return valuableObjects.first { object in
            object.keywords.contains { keyword in
                lowercasedLabel.contains(keyword)
            }
        }
    }
}
