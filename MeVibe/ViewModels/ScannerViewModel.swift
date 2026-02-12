//
//  ScannerViewModel.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//

import AVFoundation
import Combine

class ScannerViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var lastDetectedObject: String = "Scanning..."
    @Published var session = AVCaptureSession()
    @Published var foundValuableObject: ValuableObject? = nil
    @Published var isScanning: Bool = true
    
    private let visionService = VisionService()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let queue = DispatchQueue(label: "camera.queue")

    override init() {
        super.init()
        setupSession()
    }

    func setupSession() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        
        session.beginConfiguration()
        if session.canAddInput(input) { session.addInput(input) }
        
        videoOutput.setSampleBufferDelegate(self, queue: queue)
        if session.canAddOutput(videoOutput) { session.addOutput(videoOutput) }
        session.commitConfiguration()
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard isScanning else { return }
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        visionService.classify(imageBuffer: pixelBuffer) { [weak self] label in
            guard let label = label else { return }
            
            DispatchQueue.main.async {
                self?.lastDetectedObject = label
                
                if let match = ObjectDatabase.findMatch(for: label) {
                    self?.foundValuableObject = match
                    self?.isScanning = false
                }
            }
        }
    }
    
    func resetScan() {
        foundValuableObject = nil
        isScanning = true
        lastDetectedObject = "Scanning..."
    }
}

