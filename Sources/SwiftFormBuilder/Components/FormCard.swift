//
//  FormCard.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation
import SwiftUICore

public struct FormCard: FormComponent {
    public let id = UUID().uuidString
    public let title: String?
    public let subtitle: String?
    public let components: [any FormComponent]
    public let style: CardStyle
    
    public struct CardStyle {
        public var backgroundColor: Color
        public var cornerRadius: CGFloat
        public var shadowRadius: CGFloat
        public var padding: EdgeInsets
        public var borderColor: Color?
        public var borderWidth: CGFloat
        
        public init(
            backgroundColor: Color = Color.gray,
            cornerRadius: CGFloat = 12,
            shadowRadius: CGFloat = 2,
            padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
            borderColor: Color? = nil,
            borderWidth: CGFloat = 0
        ) {
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.shadowRadius = shadowRadius
            self.padding = padding
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }
    }
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        style: CardStyle = CardStyle(),
        @FormComponentBuilder components: () -> [any FormComponent]
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.components = components()
    }
}
