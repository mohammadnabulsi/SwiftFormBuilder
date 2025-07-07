//
//  FormRow.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

struct FormRow: FormComponent {
    let id = UUID().uuidString
    let components: [any FormComponent]
    let spacing: CGFloat
    let alignment: VerticalAlignment
    
    init(spacing: CGFloat = 16, alignment: VerticalAlignment = .top, @FormComponentBuilder components: () -> [any FormComponent]) {
        self.spacing = spacing
        self.alignment = alignment
        self.components = components()
    }
}
