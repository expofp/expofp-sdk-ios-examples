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
    @Namespace private var namespace
    @State private var showPlan = false
    let exhibitor: ExpoFpExhibitor

    var body: some View {
        ZStack {
            content

            if showPlan {
                store.map.getView()
                    .matchedGeometryEffect(id: exhibitor.id, in: namespace, isSource: showPlan)
                    .zIndex(1)
                    .overlay {
                        planButtons.padding(10)
                    }
            }
        }
        .navigationTitle(exhibitor.name)
        .toolbar(showPlan ? .hidden : .visible, for: .navigationBar)
        .background(.gray.opacity(0.1))
        .onAppear {
            store.miniMap.selectExhibitor(nameOrExternalId: exhibitor.externalId)
            store.map.selectExhibitor(nameOrExternalId: exhibitor.externalId)
        }
        .onDisappear {
            store.miniMap.selectExhibitor()
            store.miniMap.fitBounds()
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

                    store.miniMap.getView()
                        .frame(height: 200)
                        .allowsHitTesting(false)
                        .matchedGeometryEffect(id: exhibitor.id, in: namespace, isSource: !showPlan)
                        .overlay {
                            planButtons.padding(10)
                        }

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

    private var planButtons: some View {
        HStack {
            Spacer()

            VStack(alignment: .trailing) {
                Button {
                    withAnimation(.easeInOut) {
                        showPlan.toggle()
                    } completion: {
                        if !showPlan {
                            store.map.selectRoute()
                            store.map.selectExhibitor(nameOrExternalId: exhibitor.externalId)
                        }
                    }
                } label: {
                    Image(.frame)
                        .padding(8)
                        .background(.white)
                        .clipShape(.circle)
                }

                Spacer()

                Button {
                    withAnimation(.easeInOut) {
                        showPlan = true
                        store.map.selectRoute(from: .booth("Entrance"), to: .booth("4.1-36"))
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(.directions)
                        Text("Directions").foregroundStyle(.black)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.white)
                    .clipShape(.capsule)
                }
            }
        }
    }
}
