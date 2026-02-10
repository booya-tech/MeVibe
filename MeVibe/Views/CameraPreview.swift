//
//  CameraPreview.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
