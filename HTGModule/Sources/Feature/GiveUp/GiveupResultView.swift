//
//  GiveupResultView.swift
//  HTG
//
//  Created by 송영모 on 9/18/24.
//

import SwiftUI

import DomainInterface

public struct GiveupResultView: View {
    var viewModel: GiveupViewModel
    
    public init(viewModel: GiveupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        rootView
            .navigationTitle("결과 및 종료")
    }
}

extension GiveupResultView {
    private var rootView: some View { ㅇ
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CalloutBlock(title: "고생하셨습니다. 포기란 쉬운 것일 수도, 어려운 것 일 수도 있지만 더 나은 방향으로 결정을 도울 수 있으면 좋겠습니다. 결과를 요약해드리겠습니다.")

                    section(
                        title: "기본 정보",
                        subs: descriptionSectionSubs()
                    )
                    section(
                        title: "1. 포기 정하기",
                        subs: [viewModel.title]
                    )
                    section(
                        title: "2. 지속된 기간",
                        subs: dateSectionSubs(date: viewModel.date ?? .now)
                    )
                    section(
                        title: "3. 감정 떠올리기",
                        subs: feelSectionSubs(feels: viewModel.selectedFeels)
                    )
                    section(
                        title: "4. 대안 찾기",
                        subs: otherOptionSectionSubs(otherOptions: viewModel.otherOptions)
                    )
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        self.viewModel.delegate?.requestNavigation(self.viewModel, to: nil)
                    } label: {
                        Text("처음으로 돌아가기")
                    }
                    .buttonStyle(.htgPrimary(size: .m, stretch: true))
                    Button {
                        
                    } label: {
                        Text("리뷰 남기러가기")
                    }
                    .buttonStyle(.htgPrimaryOutlined(size: .m, stretch: true))
                }
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

    private func descriptionSectionSubs() -> [String] {
        var subs: [String] = []
        
        let duration = Date.now.timeIntervalSince(viewModel.startedAt)
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60

        subs.append("\(String(format: "%d", minutes))분 \(String(format: "%d", seconds))초 동안 설문을 진행하였습니다.")
        subs.append("어떤 것을 포기할지 고민하는 과정에서 \(viewModel.chats.count)개의 대화를 진행하였습니다.")
        subs.append("'\(viewModel.title)'을 떠올리면 \(viewModel.selectedFeels.count)개의 감정이 떠오른다고 답변하였습니다.")

        return subs
    }
    
    private func dateSectionSubs(date: Date) -> [String] {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
        let timeUnits = [
            (components.year, "년"),
            (components.month, "개월"),
            (components.day, "일"),
            (components.hour, "시간"),
            (components.minute, "분"),
            (components.second, "초")
        ]
        
        let result: [String] = timeUnits.compactMap { (value, unit) in
            guard let value = value, value > 0 else { return nil }
            return "\(value)\(unit)"
        }
        
        if result.isEmpty {
            return ["방금 전"]
        } else if result.count == 1 {
            return ["\(result[0]) 동안"]
        } else {
            let lastIndex = result.count - 1
            return [result[0..<lastIndex].joined(separator: ", ") + " 그리고 " + result[lastIndex] + " 동안"]
        }
    }


    private func feelSectionSubs(feels: [FeelModel]) -> [String] {
        var positiveFeels: [FeelModel] = []
        var negativeFeels: [FeelModel] = []
        var etcFeels: [FeelModel] = []

        for feel in viewModel.selectedFeels {
            if case .negative = feel {
                negativeFeels.append(feel)
            } else if case .positive = feel {
                positiveFeels.append(feel)
            } else {
                etcFeels.append(feel)
            }
        }
        let totalCount = viewModel.selectedFeels.count
        let negativePercentage = totalCount > 0 ? Double(negativeFeels.count) / Double(totalCount) * 100 : 0
        let positivePercentage = totalCount > 0 ? Double(positiveFeels.count) / Double(totalCount) * 100 : 0
        let etcPercentage = totalCount > 0 ? Double(etcFeels.count) / Double(totalCount) * 100 : 0

        var subs: [String] = []
        subs.append("긍정적인 감정: \(positiveFeels.map { $0.title }.joined(separator: ", "))")
        subs.append("부정적인 감정: \(negativeFeels.map { $0.title }.joined(separator: ", "))")
        subs.append("그 외 감정: \(etcFeels.map { $0.title }.joined(separator: ", "))")
        subs.append(String(format: "긍정적인 감정이 %.0f%%, 부정적인 감정이 %.0f%%, 그 외 감정이 %.0f%% 입니다.", positivePercentage, negativePercentage, etcPercentage))
        
        return subs
    }

    private func otherOptionSectionSubs(otherOptions: [String]) -> [String] {
        var subs: [String] = []
        for i in 0..<otherOptions.count {
            subs.append("\(i+1). \(otherOptions[i])")
        }
        return subs
    }
}

#Preview {
    GiveupResultView(viewModel: .init())
}
