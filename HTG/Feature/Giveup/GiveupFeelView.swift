//
//  GiveupFeelView.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI

public struct GiveupFeelView: View {
    var viewModel: GiveupViewModel
    @State var speed: Double = 10.0
    @State var maxFeelCounts: Int = 50
    
    let feels: [FeelModel] = FeelModel.allCases.shuffled()
    
    public var body: some View {
        rootView
            .navigationTitle("감정 설정하기")
    }
}

extension GiveupFeelView {
    private var rootView: some View {
        ZStack {
            ScrollView {
                VStack {
                    CalloutBlock(title: "\((viewModel.date ?? .now).day)일이나 지속 되었군요. 힘들겠지만, 감정을 떠올려보세요. 어렵다면 나중에 해도 괜찮습니다.")
                        .padding()
                    selectedFeelsView
                    feelView
                        .padding(.vertical)
                }
            }
            .padding(.bottom, 100)
            
            VStack {
                Spacer()
                buttons
            }
            .padding()
        }
    }
    
    private var selectedFeelsView: some View {
        VStack {
            var positiveCounts = 0
            var negativeCounts = 0
            var etcCounts = 0
            let _ = viewModel.selectedFeels.forEach {
                switch $0 {
                case .positive:
                    positiveCounts += 1
                case .negative:
                    negativeCounts += 1
                case .etc:
                    etcCounts += 1
                }
            }
            
            Text("긍정적인 감정: \(positiveCounts)")
            Text("부정적인 감정: \(negativeCounts)")
            Text("기타 감정: \(etcCounts)")
        }
        .font(.caption)
    }
    
    private var feelView: some View {
        LazyVGrid(columns: [.init(), .init(), .init(), .init()], spacing: 10) {
            ForEach(feels.prefix(maxFeelCounts), id: \.title) { feel in
                Button {
                    viewModel.toggleFeel(feel: feel)
                } label: {
                    Text(feel.title)
                        .underline(viewModel.selectedFeels.contains(where: { $0.title == feel.title }))
                }
                .foregroundStyle(.blackOr)
            }
        }
    }
    
    private var buttons: some View {
        HStack {
            Button {
                self.maxFeelCounts += 8
            } label: {
                Text("더보기")
            }
            .buttonStyle(.htgPrimaryOutlined(size: .l))
            Button {
                viewModel.navigate(dest: .another)
            } label: {
                Text("다음으로")
            }
            .buttonStyle(.htgPrimary(size: .l, stretch: true))
        }
    }
}

#Preview {
    GiveupFeelView(viewModel: .init())
}
