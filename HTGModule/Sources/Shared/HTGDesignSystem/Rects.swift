//
//  Rects.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI

public struct CalloutRectModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background {
                Rectangle()
                    .fill(.thinMaterial)
            }
    }
}

extension View {
    public func calloutRect() -> some View {
        modifier(CalloutRectModifier())
    }
}

#Preview {
    Text("Hello, world! Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!Hello, world!")
        .calloutRect()
}
