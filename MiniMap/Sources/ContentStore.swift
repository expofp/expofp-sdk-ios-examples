//
//  ContentStore.swift
//  MiniMap
//
//  Created by Nikita Kolesnikov on 04.03.2026.
//  Copyright © 2026 ExpoFP. All rights reserved.
//

import Combine
import ExpoFP
import Foundation

@MainActor
final class ContentStore: ObservableObject {
    let presenter = ExpoFpPlan.createPlanPresenter(with: .expoKey("demo"), additionalParams: [.noOverlay(true)])
}
