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

                VStack(spacing: 10) {
                    Text("Current Object:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text(viewModel.lastDetectedObject.capitalized)
                        .font(.title2.bold())
                        .foregroundColor(.green)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(.ultraThinMaterial))
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    ScannerView()
}
