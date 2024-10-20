//
//  TypingChatAnimationView.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI

public struct TypingChatAnimationView: View {
    private let title: String
    @Binding var isTyping: Bool
    @State private var typingTitle: String = ""
    
    public init(isTyping: Binding<Bool>, title: String) {
        self._isTyping = isTyping
        self.title = title
    }
    
    public var body: some View {
        Text(typingTitle)
            .onAppear {
                Task {
                    isTyping = true
                    for char in Array(title) {
                        typingTitle += String(char)
                        try await Task.sleep(for: .milliseconds(50))
                    }
                    withAnimation {
                        isTyping = false
                    }
                }
            }
    }
}
