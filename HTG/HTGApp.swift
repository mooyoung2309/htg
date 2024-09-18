//
//  HTGApp.swift
//  HTG
//
//  Created by 송영모 on 9/15/24.
//

import SwiftUI

@main
struct HTGApp: App {
    var body: some Scene {
        WindowGroup {
            HomeNavigationView(viewModel: .init())
        }
    }
}
