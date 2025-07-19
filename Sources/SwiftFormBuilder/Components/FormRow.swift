//
//  FormRow.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

public struct FormRow: FormComponent {
    public let id = UUID().uuidString
    public let components: [any FormComponent]
    public let spacing: CGFloat
    public let alignment: VerticalAlignment
    
    public init(spacing: CGFloat = 16, alignment: VerticalAlignment = .top, @FormComponentBuilder components: () -> [any FormComponent]) {
        self.spacing = spacing
        self.alignment = alignment
        self.components = components()
    }
}
