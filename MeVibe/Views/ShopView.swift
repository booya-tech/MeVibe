//
//  ShopView.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import SwiftUI

struct ShopView: View {
    @StateObject private var viewModel = ShopViewModel()
    @ObservedObject var dataManager: DataManager
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Points Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Your Balance")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack(spacing: 6) {
                            Text("\(viewModel.totalPoints)")
                                .font(.title.bold())
                            Text("points")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Image(systemName: "leaf.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                
                // Category Picker
                Picker("Category", selection: $viewModel.selectedCategory) {
                    ForEach(ShopCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Items Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.filteredItems) { item in
                            ShopItemCard(
                                item: item,
                                isPurchased: viewModel.isPurchased(item),
                                canAfford: viewModel.canAfford(item),
                                onTap: { viewModel.attemptPurchase(item) }
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Shop")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.dataManager = dataManager
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showPurchaseAlert) {
            if let item = viewModel.selectedItem,
               !viewModel.isPurchased(item),
               viewModel.canAfford(item) {
                Button("Cancel", role: .cancel) {}
                Button("Buy") {
                    viewModel.confirmPurchase()
                }
            } else {
                Button("OK", role: .cancel) {}
            }
        }
    }
}

