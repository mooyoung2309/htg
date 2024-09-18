//
//  File.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI

public struct EmptyTypingChatAnimationView: View {
    private let duration: Double
    @State private var toggle = [false, false, false]
    
    public init(duration: Double = 0.5) {
        self.duration = duration
    }

    public var body: some View {
        rootView
            .onAppear {
                Task {
                    let delay = duration / 3
                    toggle[0] = true
                    try await Task.sleep(for: .seconds(delay))
                    toggle[1] = true
                    try await Task.sleep(for: .seconds(delay))
                    toggle[2] = true
                }
            }
    }

    @ViewBuilder
    private var rootView: some View {
        let offset: CGFloat = 3
        let circle = Circle()
            .frame(width: 6, height: 6)
        let animation: Animation = .easeInOut(duration: duration)
        HStack(spacing: 4) {
            circle
                .offset(y: toggle[0] ? offset : -offset)
                .animation(
                    animation
                        .repeatForever(autoreverses: true),
                    value: toggle
                )
            circle
                .offset(y: toggle[1] ? offset : -offset)
                .animation(
                    animation
                        .repeatForever(autoreverses: true),
                    value: toggle
                )
            circle
                .offset(y: toggle[2] ? offset : -offset)
                .animation(
                    animation
                        .repeatForever(autoreverses: true),
                    value: toggle
                )
        }
        .foregroundStyle(.gray)
    }
}
