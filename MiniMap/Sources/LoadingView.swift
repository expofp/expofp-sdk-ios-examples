//
//  LoadingView.swift
//  MiniMap
//
//  Created by Nikita Kolesnikov on 04.03.2026.
//  Copyright © 2026 ExpoFP. All rights reserved.
//

import ExpoFP
import SwiftUI

struct LoadingView: View {

    @Binding var status: ExpoFpPlanStatus
    @State private var rotation: Double = 0

    var body: some View {
        VStack {
            Image(.loading)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                        rotation = -360
                    }
                }

            Text(status.description)
        }
    }
}
