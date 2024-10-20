//
//  GiveupAnotherView.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import Foundation
import SwiftUI

public struct GiveupOtherOptionView: View {
    @State var viewModel: GiveupViewModel
    
    @State private var input: String = ""
    
    public init(viewModel: GiveupViewModel) {
        self.viewModel = viewModel
        self.input = input
    }
    
    public var body: some View {
        rootView
            .navigationTitle("대안 찾기")
    }
}

extension GiveupOtherOptionView {
    private var rootView: some View {
        VStack {
            CalloutBlock(title: callOutMessage)
                .padding()
            
            VStack(spacing: 10) {
                ForEach(Array(viewModel.otherOptions.enumerated()), id: \.offset) { i, option in
                    HStack {
                        Text("\(i+1). \(option)")
                        Spacer()
                        Button {
                            viewModel.otherOptions.remove(at: i)
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            HStack {
                TextField("대안을 입력해주세요.", text: $input)
                    .frame(height: 39)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(.htg(.black), lineWidth: 1)
                    }
                    .onSubmit {
                        viewModel.addOtherOption(option: input)
                        input = ""
                    }
                if !viewModel.otherOptions.isEmpty {
                    Button {
                        viewModel.delegate?.requestNavigation(self.viewModel, to: .result)
                    } label: {
                        Text("다음으로")
                    }
                    .buttonStyle(.htgPrimary(size: .m))
                }
            }
        }
        .padding()
    }
    
    private var callOutMessage: String {
        var positiveCount = 0
        var negativeCount = 0
        var etcCount = 0

        for feel in viewModel.selectedFeels {
            if case .negative = feel {
                negativeCount += 1
            } else if case .positive = feel {
                positiveCount += 1
            } else {
                etcCount += 1
            }
        }
        let totalCount = viewModel.selectedFeels.count
        let negativePercentage = totalCount > 0 ? Double(negativeCount) / Double(totalCount) * 100 : 0
        let positivePercentage = totalCount > 0 ? Double(positiveCount) / Double(totalCount) * 100 : 0
        let etcPercentage = totalCount > 0 ? Double(etcCount) / Double(totalCount) * 100 : 0
        
        return String(format: "긍정적인 감정이 %.0f%%, 부정적인 감정이 %.0f%%, 그 외 감정이 %.0f%% 이네요. 만약 이것을 포기한다면 어떤 대안이 있을까요?", positivePercentage, negativePercentage, etcPercentage)
    }
}

#Preview {
    GiveupOtherOptionView(viewModel: .init(selectedFeels: []))
}
