//
//  HomeViewModel.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import Foundation

public enum HomeDestination: Hashable {
    case giveup(GiveupDestination)
}

@Observable
public class HomeViewModel {
    public var path: [HomeDestination] = []
    
    public var giveupViewModel: GiveupViewModel = .init()
    
    public init() {
        self.giveupViewModel.delegate = self
    }
}

extension HomeViewModel: GiveupViewModelDelegate {
    public func requestNavigation(_ viewModel: GiveupViewModel, to: GiveupDestination) {
        self.path.append(.giveup(to))
    }
}
