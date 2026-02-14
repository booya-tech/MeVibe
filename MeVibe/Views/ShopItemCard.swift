//
//  ShopItemCard.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import SwiftUI

struct ShopItemCard: View {
    let item: ShopItem
    let isPurchased: Bool
    let canAfford: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                // Emoji placeholder (will be 3D model later)
                Text(item.emoji)
                    .font(.system(size: 50))
                    .frame(height: 60)
                
                // Item name
                Text(item.name)
                    .font(.subheadline.bold())
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                // Price or status
                if isPurchased {
                    Text("Owned")
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                } else {
                    HStack(spacing: 4) {
                        Text("\(item.price)")
                            .font(.caption.bold())
                        Text("pts")
                            .font(.caption2)
                    }
                    .foregroundColor(canAfford ? .blue : .gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(canAfford ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(isPurchased ? Color.green : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isPurchased)
        .opacity(isPurchased ? 0.6 : 1.0)
    }
}
