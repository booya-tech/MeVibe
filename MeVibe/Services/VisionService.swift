//
//  VisionService.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//

import Vision
import CoreML

struct DetectionResult {
    let label: String
    let confidence: Float
}

class VisionService {
    private var model: VNCoreMLModel?

    init() {
        let config = MLModelConfiguration()
        if let coreMLModel = try? MobileNetV2(configuration: config) {
            self.model = try? VNCoreMLModel(for: coreMLModel.model)
        }
    }

    func classify(imageBuffer: CVImageBuffer, completion: @escaping (DetectionResult?) -> Void) {
        guard let model = model else { return }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first else {
                completion(nil)
                return
            }
            
            // Return both label and confidence
            let result = DetectionResult(
                label: topResult.identifier,
                confidence: topResult.confidence
            )
            completion(result)
        }

        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, options: [:])
        try? handler.perform([request])
    }
}
