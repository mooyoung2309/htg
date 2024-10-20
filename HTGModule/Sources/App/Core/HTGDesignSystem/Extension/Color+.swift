//
//  File.swift
//  
//
//  Created by 송영모 on 9/20/24.
//

import SwiftUI

extension Color {
    public static func htg(_ kind: HTGColor.Kind, opacity: Double = 1.0) -> Self {
        return HTGColor(kind: kind, opacity: opacity).color
    }
}
