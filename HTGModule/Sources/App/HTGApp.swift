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
            GiveupOtherOptionView.init(viewModel: .init(selectedFeels: [.negative(.afraid), .positive(.confident), .negative(.annoyed)]))
//            HomeNavigationView(viewModel: .init())
        }
    }
}
