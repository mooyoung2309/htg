//
//  GiveupViewModel.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI
import DomainInterface

public protocol GiveupViewModelDelegate: AnyObject {
    func requestNavigation(_ viewModel: GiveupViewModel, to: GiveupDestination?)
}

@MainActor @Observable
public class GiveupViewModel {
    var startedAt: Date

    var title: String = ""
    var date: Date?
    var chats: [ChatModel]
    var selectedFeels: [FeelModel]
    var otherOptions: [String]
    
    weak var delegate: (any GiveupViewModelDelegate)?
    
    public init(
        startedAt: Date = .now,
        title: String = "",
        date: Date? = nil,
        chats: [ChatModel] = [],
        selectedFeels: [FeelModel] = [],
        otherOptions: [String] = []
    ) {
        self.startedAt = startedAt
        self.title = title
        self.date = date
        self.chats = chats
        self.selectedFeels = selectedFeels
        self.otherOptions = otherOptions
    }

    public func onAppear() {
        self.startedAt = .now
    }
    
    public func navigate(dest: GiveupDestination) {
        self.delegate?.requestNavigation(self, to: dest)
    }
    
    public func sendMessage(message: String) {
        let userChat = ChatModel.init(role: .user, message: message)
        let systemChat = ChatModel.init(role: .system, message: "\(message)을 포기하고 싶은건가요?")
        
        self.title = message
        self.chats.append(userChat)

        Task {
            do {
                try await Task.sleep(for: .milliseconds(200))
                self.chats.append(systemChat)
            } catch {
                print(error)
            }
        }
    }
    
    public func toggleFeel(feel: FeelModel) {
        if let index = selectedFeels.firstIndex(where: { feel.title == $0.title }) {
            self.selectedFeels.remove(at: index)
        } else {
            self.selectedFeels.append(feel)
        }
    }
    
    public func addOtherOption(option: String) {
        self.otherOptions.append(option)
    }
}

public enum GiveupDestination: Sendable {
    case onboard
    case title
    case date
    case feel
    case another
    case result
}
