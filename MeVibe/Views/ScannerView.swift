//
//  ScannerView.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//
import SwiftUI

struct ScannerView: View {
    @StateObject private var viewModel = ScannerViewModel()

    var body: some View {
        ZStack {
            // Full screen camera
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()

            // Overlay UI
            VStack {
                Text("My Vibe")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(10)

                Spacer()
                
                if let valuable = viewModel.foundValuableObject {
                    VStack(spacing: 15) {
                        // Found
                        Text("Found 🎉")
                            .font(.title2.bold())
                            .foregroundStyle(Color.white)
                        // Item Name
                        Text(valuable.name)
                            .font(.title3)
                            .foregroundStyle(Color.white)
                        // Claim Point
                        Button {
                            //TODO: - Save to Database
                            viewModel.resetScan()
                        } label: {
                            Text("Claim Points")
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
                        Text("Scanning for:")
                            .font(.caption)
                            .foregroundStyle(.white)
                        // Hint
                        Text("Plants • Books • Coffee")
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
    }
}

#Preview {
    ScannerView()
}
