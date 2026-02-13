//
//  ScannerView.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//
import SwiftUI
import SwiftData

struct ScannerView: View {
    @StateObject private var viewModel = ScannerViewModel()
    @Environment(\.modelContext) private var modelContext
    @State private var dataManager: DataManager?

    var body: some View {
        ZStack {
            // Full screen camera
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()

            // Overlay UI
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(AppStrings.appName)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Text("\(dataManager?.totalPoints ?? 0) \(AppStrings.points)")
                            .font(.headline)
                            .foregroundStyle(.yellow)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding()
                
                Spacer()
                
                if let valuable = viewModel.foundValuableObject {
                    VStack(spacing: 15) {
                        // Found
                        Text(AppStrings.scannerFound)
                            .font(.title2.bold())
                            .foregroundStyle(Color.white)
                        // Item Name
                        Text(valuable.name)
                            .font(.title3)
                            .foregroundStyle(Color.white)
                        // Claim Point
                        Button {
                            viewModel.claimPoints()
                        } label: {
                            Text(AppStrings.claimPoints)
                                .font(.headline)
                                .foregroundStyle(Color.yellow)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(15)
                        }
                    }
                    .padding(30)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThickMaterial))
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                } else {
                    // Scanning State
                    VStack(spacing: 15) {
                        // Scanning for
                        Text(AppStrings.scanningStateTitle)
                            .font(.caption)
                            .foregroundStyle(.white)
                        // Hint
                        Text(AppStrings.scanningStateHint)
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.8))
                        // Last Object Detecting
                        Text(viewModel.lastDetectedObject.capitalized)
                            .font(.title2.bold())
                            .foregroundStyle(Color.blue)
                            .padding(.top, 5)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            if dataManager == nil {
                dataManager = DataManager(modelContext: modelContext)
                viewModel.dataManager = dataManager
            }
        }
    }
}

#Preview {
    ScannerView()
}
