//
//  Buttons.swift
//  HTG
//
//  Created by 송영모 on 9/16/24.
//

import SwiftUI

extension ButtonStyle where Self == HTGPrimaryButtonStyle {
    public static func htgPrimary(size: ButtonSize, stretch: Bool = false) -> HTGPrimaryButtonStyle {
        HTGPrimaryButtonStyle(size: size, stretch: stretch)
    }
}
extension ButtonStyle where Self == HTGPrimaryOutlinedButtonStyle {
    public static func htgPrimaryOutlined(size: ButtonSize, stretch: Bool = false) -> HTGPrimaryOutlinedButtonStyle {
        HTGPrimaryOutlinedButtonStyle(size: size, stretch: stretch)
    }
}

public enum ButtonSize {
    case l, m, s
}

public struct HTGPrimaryButtonStyle: ButtonStyle {
    public var size: ButtonSize
    public var stretch: Bool
    public func makeBody(configuration: Configuration) -> some View {
        let label = Group {
            if stretch {
                configuration.label
                    .frame(maxWidth: .infinity)
            } else {
                configuration.label
            }
        }

        label
            .modifier(
                HTGButtonStyleModifier(
                    size: size,
                    isPressed: configuration.isPressed,
                    textColor: .whiteOr,
                    fillColor: .blackOr,
                    pressedColor: .blackOr
                )
            )
    }

    private var fillColor: Color {
        return .black
    }

    private var pressedColor: Color {
        return .gray
    }
}

public struct HTGPrimaryOutlinedButtonStyle: ButtonStyle {
    public var size: ButtonSize
    public var stretch: Bool
    public func makeBody(configuration: Configuration) -> some View {
        let label = Group {
            if stretch {
                configuration.label
                    .frame(maxWidth: .infinity)
            } else {
                configuration.label
            }
        }

        label
            .modifier(
                HTGButtonStyleModifier(
                    size: size,
                    isPressed: configuration.isPressed,
                    textColor: .blackOr,
                    fillColor: .clear,
                    pressedColor: .clear,
                    borderColor: .blackOr
                )
            )
    }
}

private struct HTGButtonStyleModifier: ViewModifier {
    var size: ButtonSize
    var isPressed: Bool
    var textColor: Color
    var fillColor: Color
    var pressedColor: Color
    var borderColor: Color?

    @State private var isPressEffect = false
    @State private var delayTask: Task<Void, any Error>?

    @Environment(\.isEnabled) private var isEnabled

    func body(content: Content) -> some View {
        let pressEffect = isPressed || isPressEffect
        content
            .font(size.font)
            .foregroundStyle(isEnabled ? textColor : .gray)
            .padding(size.paddingInsets)
            .background {
                OZDisablableRect(
                    cornerRadius: size.cornerRadius,
                    fillColor: pressEffect ? pressedColor : fillColor,
                    borderColor: borderColor
                )
            }
            .scaleEffect(pressEffect ? 0.95 : 1.0)
            .animation(.easeOut(duration: 1/6), value: pressEffect)
            .onChange(of: isPressed) { old, new in
                if new {
                    isPressEffect = true
                    delayTask?.cancel()
                    delayTask = Task {
                        try await Task.sleep(nanoseconds: 100 * NSEC_PER_MSEC)
                        isPressEffect = false
                    }
                }
            }
    }
}

private struct OZDisablableRect: View {
    var cornerRadius: CGFloat
    var fillColor: Color
    var borderColor: Color?
    @Environment(\.isEnabled) private var isEnabled
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .foregroundColor(isEnabled ? fillColor : .gray)
            if isEnabled, let borderColor {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(lineWidth: 1.0)
                    .foregroundColor(borderColor)
            }
        }
    }
}

private extension ButtonSize {

    var font: SwiftUI.Font {
        switch self {
        case .l:
            return .title3
        case .m:
            return .body
        case .s:
            return .body
        }
    }

    var paddingInsets: EdgeInsets {
        switch self {
        case .l:
            EdgeInsets(top: 13, leading: 18, bottom: 13, trailing: 18)
        case .m:
            EdgeInsets(top: 9, leading: 14, bottom: 9, trailing: 14)
        case .s:
            EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10)
        }
    }

    var cornerRadius: CGFloat {
        return 0
        switch self {
        case .l:
            12
        case .m:
            10
        case .s:
            8
        }
    }
}

extension LabelStyle where Self == OZTextButtonLabelStyle {
    public static func ozTextButton(iconPlacement: OZTextButtonLabelStyle.IconPlacement = .left) -> OZTextButtonLabelStyle {
        OZTextButtonLabelStyle(iconPlacement: iconPlacement)
    }
}

public struct OZTextButtonLabelStyle: LabelStyle {
    public enum IconPlacement {
        case left, right
    }
    public var iconPlacement: IconPlacement
    public init(iconPlacement: IconPlacement = .left) {
        self.iconPlacement = iconPlacement
    }
    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 4) {
            let icon = configuration.icon
                .frame(width: 16, height: 16)
            if iconPlacement == .left { icon }
            configuration.title
            if iconPlacement == .right { icon }
        }
    }
}


