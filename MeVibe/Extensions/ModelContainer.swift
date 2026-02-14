//
//  ModelContainer.swift
//  MeVibe
//
//  Created by Panachai Sulsaksakul on 2/13/26.
//

import SwiftData

// Helper for ModelContainer
extension ModelContainer {
    static var shared: ModelContainer = {
        let schema = Schema([User.self, ScanRecord.self])
        let configuration = ModelConfiguration(schema: schema)
        return try! ModelContainer(for: schema, configurations: [configuration])
    }()
}
