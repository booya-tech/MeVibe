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
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        ZStack {
            // Full screen camera
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()

            // Overlay UI
            VStack {
                // Header with points display
                HStack {
                    VStack(alignment: .leading) {
                        Text(AppStrings.appName)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Text("\(dataManager.totalPoints) \(AppStrings.points)")
                            .font(.headline)
                            .foregroundColor(.yellow)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.5))
                .cornerRadius(10)
                .padding()

                Spacer()

                // Detection Display
                if let valuable = viewModel.foundValuableObject {
                    // SUCCESS STATE
                    VStack(spacing: 15) {
                        Text(AppStrings.scannerFound)
                            .font(.title3.bold())
                            .foregroundColor(.green)
                        
                        Text(valuable.name)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("+\(valuable.points) \(AppStrings.points)")
                            .font(.title2)
                            .foregroundColor(.yellow)
                        
                        Button(action: {
                            viewModel.claimPoints()
                        }) {
                            Text(AppStrings.claimPoints)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                    }
                    .padding(30)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                    .padding(.horizontal)
                    .padding(.bottom, 50)
                } else {
                    // SCANNING STATE
                    VStack(spacing: 10) {
                        Text(AppStrings.scanningStateTitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(AppStrings.scanningStateHint)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(viewModel.lastDetectedObject.capitalized)
                            .font(.title2.bold())
                            .foregroundColor(.green)
                            .padding(.top, 5)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            viewModel.dataManager = dataManager
        }
    }
}
