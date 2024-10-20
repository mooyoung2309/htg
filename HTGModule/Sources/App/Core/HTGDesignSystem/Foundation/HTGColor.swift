//
//  File.swift
//  
//
//  Created by 송영모 on 9/20/24.
//

import Foundation
import SwiftUI

public struct HTGColor: Equatable, Hashable {
    public let kind: Kind
    public var opacity: Double

    public init(kind: Kind, opacity: Double = 1.0) {
        self.kind = kind
        self.opacity = opacity
    }

    public func withOpacity(_ opacity: Double) -> Self {
        HTGColor(kind: self.kind, opacity: opacity)
    }

    public var color: Color {
        kind.color.opacity(opacity)
    }
}

extension HTGColor {
    public enum Kind {
        case black
        case white
    }
}

extension HTGColor.Kind {
    fileprivate var color: Color {
        switch self {
        case .black: return .init("Black", bundle: .module)
        case .white: return .init("White", bundle: .module)
        }
    }
}
