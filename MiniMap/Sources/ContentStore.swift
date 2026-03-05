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
    let miniMap = ExpoFpPlan.createPlanPresenter(with: .expoKey("demo"))
    let map = ExpoFpPlan.createPlanPresenter(with: .expoKey("demo"))
}
