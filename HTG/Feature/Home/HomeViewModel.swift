//
//  HomeViewModel.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import Foundation

enum HomeDestination: Hashable {
    case giveup(GiveupDestination)
}

@Observable
class HomeViewModel {
    public var path: [HomeDestination] = []
    
    public var giveupViewModel: GiveupViewModel = .init()
    
    init() { 
        self.giveupViewModel.delegate = self
    }
}

extension HomeViewModel: GiveupViewModelDelegate {
    func requestNavigation(_ viewModel: GiveupViewModel, to: GiveupDestination) {
        self.path.append(.giveup(to))
    }
}
