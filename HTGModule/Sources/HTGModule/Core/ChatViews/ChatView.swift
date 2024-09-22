//
//  ChatView.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import Foundation
import SwiftUI

public enum ChatStyle {
    case primary
    case outlined
    
    var fillColor: Color {
        switch self {
        case .primary: return .gray6
        case .outlined: return .clear
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .primary: return .clear
        case .outlined: return .htg(.black)
        }
    }
}

extension View {
    public func chatRect(_ style: ChatStyle) -> some View {
        self.padding(10)
            .frame(minHeight: 50)
            .background {
                RoundedRectangle(cornerRadius: 0)
                    .fill(style.fillColor)
                    .stroke(style.strokeColor)
            }
    }
}
