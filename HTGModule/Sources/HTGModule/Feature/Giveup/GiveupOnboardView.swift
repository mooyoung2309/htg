//
//  GiveupView.swift
//  HTG
//
//  Created by 송영모 on 9/15/24.
//

import SwiftUI

public struct GiveupOnboardView: View {
    @State var viewModel: GiveupViewModel
    
    public init(viewModel: GiveupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        rootView
            .navigationTitle("포기")
    }
}

extension GiveupOnboardView {
    private var rootView: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(GiveupOnboardSection.allCases, id: \.title) { onboard in
                        section(title: onboard.title, subs: onboard.subs)
                    }
                }
            }
            VStack {
                Spacer()
                Button {
                    self.viewModel.navigate(dest: .title)
                } label: {
                    Text("시작하기")
                }
                .buttonStyle(.htgPrimary(size: .l, stretch: true))
            }
        }
        .padding(.horizontal)
    }
    private func section(title: String, subs: [String]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.body)
                .underline()
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            ForEach(subs, id: \.self) { sub in
                Text(sub)
                    .font(.caption)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    
            }
        }
    }
}

enum GiveupOnboardSection: CaseIterable {
    case explanation
    case advantage
    case disadvantage
    case curriculum
    
    var title: String {
        switch self {
        case .explanation:
            return "포기란 무엇일까요?"
        case .advantage:
            return "장점"
        case .disadvantage:
            return "단점"
        case .curriculum:
            return "커리큘럼"
        }
    }
    
    var subs: [String] {
        switch self {
        case .explanation:
            return [
                "1. 하려던 일을 도중에 그만두어 버림.",
                "2. 자기의 권리나 자격, 물건 따위를 내던져 버림.",
            ]
        case .advantage:
            return [
                "1. 절약: 성과가 없거나 비현실적인 목표를 계속 추구하는 대신 포기하면 시간과 에너지를 더 유용한 곳에 투자할 수 있습니다.",
                "2. 스트레스 감소: 실패나 좌절에서 벗어나 정신적인 안정을 찾을 수 있습니다.",
                "3. 새로운 기회: 한 가지를 포기함으로써 다른 가능성이나 더 나은 기회를 추구할 수 있습니다.",
                "4. 현실적인 수정: 자신의 한계나 상황을 인정하고 보다 실현 가능한 목표를 설정할 수 있습니다."
            ]
        case .disadvantage:
            return [
                "1. 후회: 나중에 더 노력했으면 성공할 수 있었을 것이라는 후회를 느낄 수 있습니다.",
                "2. 자신감: 목표를 달성하지 못했다는 사실이 자기 효능감이나 자신감을 떨어뜨릴 수 있습니다.",
                "3. 성장 기회 상실: 어려움을 극복하는 과정에서 얻을 수 있는 개인적 성장과 경험을 놓칠 수 있습니다.",
                "4. 포기의 습관화: 작은 어려움에도 쉽게 포기하는 패턴이 형성될 수 있습니다."
            ]
        case .curriculum:
            return [
                
            ]
        }
    }
}

#Preview {
    GiveupOnboardView(viewModel: .init())
}
