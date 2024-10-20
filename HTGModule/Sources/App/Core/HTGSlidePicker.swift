//
//  File.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//
import SwiftUI

struct HTGSlidePicker: View {
    @State private var sizes: [CGFloat]
    private let minSize: CGFloat = 0.05 // 각 섹션의 최소 비율 (5%)
    private let handleWidth: CGFloat = 10 // 손잡이의 너비

    // 현재 드래그 중인 손잡이의 인덱스를 추적하기 위한 변수
    @GestureState private var activeHandleIndex: Int? = nil

    init(sectionCount: Int) {
        // 섹션 수에 따라 초기 사이즈를 설정
        let initialSize = 1.0 / CGFloat(sectionCount)
        self._sizes = State(initialValue: Array(repeating: initialSize, count: sectionCount))
    }

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let adjustedTotalWidth = totalWidth - handleWidth * CGFloat(sizes.count - 1) // 손잡이들을 제외한 총 너비

            HStack(spacing: 0) {
                ForEach(0..<sizes.count, id: \.self) { index in
                    // 섹션 뷰
                    ZStack {
                        Rectangle()
                            .fill(self.colorForIndex(index))
                        Text("\(Int(self.sizes[index] * 100))%")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: max(0, adjustedTotalWidth * self.sizes[index]))

                    // 마지막 섹션이 아니면 손잡이 추가
                    if index < self.sizes.count - 1 {
                        let handleIndex = index

                        Rectangle()
                            .fill(.htg(.white))
                            .frame(width: handleWidth)
                            .animation(.easeInOut(duration: 0.2), value: self.activeHandleIndex)
                            .gesture(
                                DragGesture()
                                    .updating($activeHandleIndex) { _, state, _ in
                                        state = handleIndex
                                    }
                                    .onChanged { value in
                                        self.adjustSizes(handleIndex: handleIndex, deltaWidth: value.translation.width, totalWidth: adjustedTotalWidth)
                                    }
                            )
                    }
                }
            }
        }
    }

    /// 주어진 인덱스에 따라 색상을 반환합니다.
    private func colorForIndex(_ index: Int) -> Color {
        let colors: [Color] = [.htg(.black)]
        return colors[index % colors.count]
    }

    /// 손잡이를 드래그할 때 사이즈를 조정하는 함수입니다.
    private func adjustSizes(handleIndex: Int, deltaWidth: CGFloat, totalWidth: CGFloat) {
        let delta = deltaWidth / totalWidth

        var newSizes = sizes

        // 조정할 섹션 인덱스
        let leftIndex = handleIndex
        let rightIndex = handleIndex + 1

        // 왼쪽과 오른쪽 섹션의 사이즈 조정
        newSizes[leftIndex] = (newSizes[leftIndex] + delta).clamped(to: minSize...1)
        newSizes[rightIndex] = (newSizes[rightIndex] - delta).clamped(to: minSize...1)

        // 최소 사이즈를 보장하기 위해 조정 후 사이즈가 최소 사이즈 미만이면 수정
        let leftDelta = newSizes[leftIndex] - sizes[leftIndex]
        let rightDelta = sizes[rightIndex] - newSizes[rightIndex]

        if newSizes[leftIndex] < minSize {
            newSizes[leftIndex] = minSize
            newSizes[rightIndex] += leftDelta
        }
        if newSizes[rightIndex] < minSize {
            newSizes[rightIndex] = minSize
            newSizes[leftIndex] += rightDelta
        }

        // 사이즈 배열의 합이 1이 되도록 정규화
        let sizeSum = newSizes.reduce(0, +)
        sizes = newSizes.map { $0 / sizeSum }
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
