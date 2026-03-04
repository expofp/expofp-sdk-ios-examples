//
//  Application.swift
//  MiniMap
//
//  Created by Nikita Kolesnikov on 04.03.2026.
//  Copyright © 2026 ExpoFP. All rights reserved.
//

import SwiftUI

@main
struct Application: App {

    @StateObject private var store = ContentStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(store)
        }
    }
}
