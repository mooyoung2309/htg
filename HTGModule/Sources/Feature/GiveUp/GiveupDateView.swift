//
//  GiveupDateView.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import SwiftUI

public struct GiveupDateView: View {
    var viewModel: GiveupViewModel
    @State private var date: Date = .now
    @State private var selectedDate: Date?
    
    public init(viewModel: GiveupViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        rootView
            .onChange(of: date) { old, new in
                selectedDate = new
                viewModel.date = new
            }
            .sheet(isPresented: .init(
                get: { selectedDate == nil },
                set: { _ in }
            )) {
                datePicker
                    .presentationDetents([.medium])
                    .interactiveDismissDisabled()
            }
            .navigationTitle("시간 설정하기")
    }
}

extension GiveupDateView {
    private var rootView: some View {
        VStack {
            CalloutBlock(title: "'\(viewModel.title)'은 언제부터 지속되었나요?")
            VStack {
                HStack {
                    VStack {
                        if let selectedDate {
                            Text(selectedDate.str)
                                .font(.footnote)
                        }
                        Text("과거")
                    }
                    Rectangle()
                        .frame(height: 1)
                    VStack {
                        Text(Date().str)
                            .font(.footnote)
                        Text("현재")
                    }
                }
                
                if let selectedDate {
                    TimelineView(.periodic(from: .now, by: 1)) { _ in
                        VStack(alignment: .leading) {
                            let currentDate = Date()
                            let interval = currentDate.timeIntervalSince(selectedDate)
                            
                            let seconds = Int(interval)
                            let minutes = seconds / 60
                            let hours = seconds / 3600
                            let days = seconds / (24 * 3600)
                            
                            Text("\(days) d")
                            Text("\(hours) h")
                            Text("\(minutes) m")
                            Text("\(seconds) s")
                        }
                        .frame(width: 200)
                        .font(.caption)
                        .padding()
                        
                        Button {
                            self.selectedDate = nil
                            self.viewModel.date = nil
                        } label: {
                            Text("다시 선택하기")
                        }
                        .buttonStyle(.htgPrimaryOutlined(size: .s))
                    }
                }
            }
            .padding(.horizontal, 50)
            
            Spacer()
            
            Button {
                if viewModel.date != nil {
                    viewModel.navigate(dest: .feel)
                }
            } label: {
                Text("다음으로")
            }
            .buttonStyle(.htgPrimary(size: .m, stretch: true))
        }
        .padding(.horizontal)
    }
    
    private var datePicker: some View {
        VStack(alignment: .leading) {
            Text("이쯤부터 시작되었습니다.")
                .font(.title3)
                .fontWeight(.bold)
            DatePicker(
                "시작한 날짜",
                selection: $date,
                in: ...Date(),
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
        .padding()
    }
}

#Preview {
    GiveupDateView(viewModel: .init())
}
