//
//  HTGApp.swift
//  HTG
//
//  Created by 송영모 on 9/15/24.
//

import SwiftUI
import Feature

public struct HTGApp: App {
    public init() {}
    public var body: some Scene {
        WindowGroup {
            HomeNavigationView(viewModel: .init())
        }
    }
}
