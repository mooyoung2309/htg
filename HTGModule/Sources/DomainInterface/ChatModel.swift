//
//  Chat.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import Foundation

public enum ChatRole: Sendable {
    case system
    case user
}

public struct ChatModel: Identifiable, Sendable {
    public let id: UUID = .init()
    public let role: ChatRole
    public let message: String
    public let action: Bool
    
    public init(role: ChatRole, message: String, action: Bool = true) {
        self.role = role
        self.message = message
        self.action = action
    }
}
