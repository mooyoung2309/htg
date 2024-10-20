//
//  GiveupTitleView.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import Foundation
import SwiftUI

public struct GiveupTitleView: View {
    @State var viewModel: GiveupViewModel
    @State private var message: String = ""
    
    public init(
        viewModel: GiveupViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        rootView
            .onAppear {
                viewModel.chats.append(.init(role: .system, message: "당신은 어떤것을 포기하려고 하시나요?", action: false))
            }
            .onDisappear {
                viewModel.chats.removeAll()
            }
            .navigationTitle("포기 설정하기")
            
    }
}

private struct SystemChatView: View {
    private let chat: ChatModel
    private let delay: Double
    
    @State var isTyping: Bool = true
    @State var showEmpty: Bool = true
    
    init(
        chat: ChatModel,
        delay: Double
    ) {
        self.chat = chat
        self.delay = delay
    }
    
    var body: some View {
        if showEmpty {
            EmptyTypingChatAnimationView()
                .font(.callout)
                .chatRect(.primary)
                .onAppear {
                    Task {
                        try await Task.sleep(for: .seconds(delay))
                        showEmpty = false
                    }
                }
        } else {
            TypingChatAnimationView(isTyping: $isTyping, title: chat.message)
                .font(.callout)
                .chatRect(.primary)
        }
    }
}


extension GiveupTitleView {
    
    private var rootView: some View {
        ZStack {
            chatView
                .padding(.bottom, 50)
            VStack {
                Spacer()
                messageView
            }
            .padding()
        }
    }
    
    private var chatView: some View {
        ScrollView {
            VStack {
                CalloutBlock(title: "첫번째로 어떤 것을 포기할 것인지 생각해보는 시간을 가져보겠습니다. 참고로 이 대화는 기록되지 않습니다.")
                    .padding()
                ForEach(viewModel.chats) { chat in
                    switch chat.role {
                    case .system:
                        systemChatView(chat: chat)
                    case .user:
                        userChatView(message: chat.message)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func systemChatView(chat: ChatModel) -> some View {
        HStack {
            SystemChatView(chat: chat, delay: 2)
            Spacer()
        }
    }
    
    private func userChatView(message: String) -> some View {
        HStack {
            Spacer()
            Text(message)
                .font(.callout)
                .chatRect(.outlined)
        }
    }
    
    private var messageView: some View {
        HStack {
            TextField("메세지를 입력해주세요.", text: $message)
                .onSubmit {
                    sendMessage()
                }
            Spacer()
            if !message.isEmpty {
                Button {
                    sendMessage()
                } label: {
                    Text("보내기")
                }
                .buttonStyle(.htgPrimary(size: .s))
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 0)
                .stroke(.black)
        }
    }
    
    private func sendMessage() {
        if message.isEmpty { return }
        viewModel.sendMessage(message: message)
        message = ""
    }
}

#Preview {
    GiveupTitleView(viewModel: .init())
}
