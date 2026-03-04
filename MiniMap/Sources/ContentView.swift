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
                    Text(exhibitor.name)
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(store.presenter.planLink.description.capitalized)
        .overlay {
            if !status.isReady {
                LoadingView(status: $status)
            }
        }
        .onReceive(store.presenter.planStatusPublisher) { status in
            self.status = status

            if status == .ready && exhibitors.isEmpty {
                prepareExhibitors()
            }
        }
    }

    private func prepareExhibitors() {
        Task {
            do {
                exhibitors = try await store.presenter.exhibitorsList().get()
            } catch {
                print(#function, error)
            }
        }
    }
}

#Preview {
    ContentView()
}
