//
//  GiveupAnotherView.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import Foundation
import SwiftUI

public struct GiveupAnotherView: View {
    @State var viewModel: GiveupViewModel
    
    @State private var input: String = ""
    
    public var body: some View {
        rootView
        
    }
}

extension GiveupAnotherView {
    private var rootView: some View {
        VStack {
            CalloutBlock(title: "부정적인 감정이 68% 이네요. 그렇다면 어떤 대안이 있을까요?")
                .padding()
            
            Spacer()
            
            Text("ddddddd")
            
            Divider()
            
            TextField("아아", text: $input)
                .padding(10)
                .background {
                    Rectangle()
                        .stroke(.blackOr)
                }
            
            Spacer()
            Button {
                
            } label: {
                Text("다음으로")
            }
            .buttonStyle(.htgPrimary(size: .l, stretch: true))
        }
        .padding()
    }
}

#Preview {
    GiveupAnotherView(viewModel: .init())
}
