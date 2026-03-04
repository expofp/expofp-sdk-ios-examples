//
//  ExhibitorView.swift
//  MiniMap
//
//  Created by Nikita Kolesnikov on 04.03.2026.
//  Copyright © 2026 ExpoFP. All rights reserved.
//

import ExpoFP
import SwiftUI

struct ExhibitorView: View {

    @EnvironmentObject private var store: ContentStore
    let exhibitor: ExpoFpExhibitor

    var body: some View {
        ZStack {
            content
        }
        .navigationTitle(exhibitor.name)
        .background(.gray.opacity(0.2))
        .onAppear {
            store.presenter.selectExhibitor(nameOrExternalId: exhibitor.externalId)
        }
        .onDisappear {
            store.presenter.selectExhibitor()
            store.presenter.fitBounds()
        }
    }

    private var content: some View {
        ScrollView {
            VStack {
                Group {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(.white)

                    store.presenter.getView()
                        .frame(height: 200)
                        .disabled(true)

                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.")
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(.white)
                }
                .clipShape(.rect(cornerRadius: 18))
            }
            .padding()
        }
    }
}
