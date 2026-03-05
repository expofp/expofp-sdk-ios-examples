//
//  ContentView.swift
//  MiniMap
//
//  Created by Nikita Kolesnikov on 04.03.2026.
//  Copyright © 2026 ExpoFP. All rights reserved.
//

import ExpoFP
import SwiftUI

struct ContentView: View {

    @EnvironmentObject private var store: ContentStore
    @State private var status = ExpoFpPlanStatus.loading(percentage: 0)
    @State private var exhibitors = [ExpoFpExhibitor]()

    var body: some View {
        List {
            ForEach(exhibitors) { exhibitor in
                NavigationLink(exhibitor.name) {
                    ExhibitorView(exhibitor: exhibitor)
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(store.miniMap.planLink.description.capitalized)
        .overlay {
            if !status.isReady {
                LoadingView(status: $status)
            }
        }
        .onReceive(store.miniMap.planStatusPublisher) { status in
            self.status = status

            if status == .ready && exhibitors.isEmpty {
                let visibility = ExpoFpElementsVisibility(controls: false, levels: false, header: false, overlay: false)
                store.miniMap.setElementsVisibility(visibility)
                store.map.setElementsVisibility(visibility)

                prepareExhibitors()
            }
        }
    }

    private func prepareExhibitors() {
        Task {
            do {
                exhibitors = try await store.miniMap.exhibitorsList().get()
            } catch {
                print(#function, error)
            }
        }
    }
}

#Preview {
    ContentView()
}
