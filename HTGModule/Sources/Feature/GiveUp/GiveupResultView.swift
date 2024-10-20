//
//  GiveupResultView.swift
//  HTG
//
//  Created by 송영모 on 9/18/24.
//

import SwiftUI

public struct GiveupResultView: View {
    var viewModel: GiveupViewModel
    
    public init(viewModel: GiveupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        rootView
            .navigationTitle("결과")
    }
}

extension GiveupResultView {
    private var rootView: some View {
        VStack(alignment: .leading) {
            Text("viewModel.title")
                .underline()
            Text("안녕하세요.")
                .font(.callout)
        }
    }
}

#Preview {
    GiveupResultView(viewModel: .init())
}
