//
//  VisionService.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/10/26.
//

import Vision
import CoreML

class VisionService {
    private var model: VNCoreMLModel?

    init() {
        let config = MLModelConfiguration()
        if let coreMLModel = try? MobileNetV2(configuration: config) {
            self.model = try? VNCoreMLModel(for: coreMLModel.model)
        }
    }

    func classify(imageBuffer: CVImageBuffer, completion: @escaping (String?) -> Void) {
        guard let model = model else { return }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                completion(nil)
                return
            }
            // Return the label with the highest confidence
            completion(results.first?.identifier)
        }

        request.imageCropAndScaleOption = .centerCrop
        let handler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, options: [:])
        try? handler.perform([request])
    }
}
