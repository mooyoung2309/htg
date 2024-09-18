//
//  CalloutBlock.swift
//  HTG
//
//  Created by 송영모 on 9/17/24.
//

import SwiftUI

public struct CalloutBlock: View {
    public let title: String
    
    public var body: some View {
        Text(title)
            .font(.caption)
            .calloutRect()
    }
}
