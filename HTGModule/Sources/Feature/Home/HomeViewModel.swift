//
//  HomeViewModel.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import Foundation

public enum HomeDestination: Sendable, Hashable {
    case giveup(GiveupDestination)
}

@MainActor @Observable
public class HomeViewModel {
    public var path: [HomeDestination] = []
    
    public var giveupViewModel: GiveupViewModel = .init()
    
    public init() {
        self.giveupViewModel.delegate = self
    }
}

extension HomeViewModel: @preconcurrency GiveupViewModelDelegate {
    public func requestNavigation(_ viewModel: GiveupViewModel, to: GiveupDestination) {
        self.path.append(.giveup(to))
    }
}
