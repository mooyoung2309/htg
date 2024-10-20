//
//  HomeView.swift
//  HTG
//
//  Created by 송영모 on 9/15/24.
//

import SwiftUI

public struct HomeNavigationView: View {
    @State var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                HomeView(viewModel: viewModel)
            }
            .navigationDestination(for: HomeDestination.self) { dest in
                switch dest {
                case .giveup(let giveupDest):
                    giveup(dest: giveupDest)
                }
            }
        }
    }
    
    @ViewBuilder
    private func giveup(dest: GiveupDestination) -> some View {
        let vm = viewModel.giveupViewModel
        switch dest {
        case .onboard:
            GiveupOnboardView(viewModel: vm)
        case .title:
            GiveupTitleView(viewModel: vm)
        case .date:
            GiveupDateView(viewModel: vm)
        case .feel:
            GiveupFeelView(viewModel: vm)
        case .another:
            GiveupOtherOptionView(viewModel: vm)
        case .result:
            GiveupResultView(viewModel: vm)
        }
    }
}

struct HomeView: View {
    var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                Button {
                    viewModel.path.append(.giveup(.onboard))
                } label: {
                    VStack(alignment: .leading) {
                        Text("포기")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("포기하는 방법에 관하여")
                            .multilineTextAlignment(.leading)
                            .font(.callout)
                        
                        HStack {
                            Spacer()
                            Text("4분 소요")
                                .font(.caption)
                        }
                    }
                    .contentShape(Rectangle())
                    .foregroundStyle(.htg(.black))
                }
                .buttonStyle(.htgPrimaryOutlined(size: .l, stretch: true))
                .padding()
            }
            
            Spacer()
            Text("우리는 사용자의 데이터를 저장하고 있지 않습니다. \n앱을 종료하면 모든 것은 지워집니다.")
                .multilineTextAlignment(.center)
                .font(.caption)
        }
    }
    
    private var tab: some View {
        VStack {
            Text("불편한 점이 있나요?")
                .foregroundStyle(.white)
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.htg(.black))
        }
    }
}

#Preview {
    @State var vm = HomeViewModel()
    return HomeView(viewModel: vm)
}
