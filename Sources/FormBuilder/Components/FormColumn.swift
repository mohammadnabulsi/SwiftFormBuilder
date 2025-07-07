//
//  FormColumn.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

struct FormColumn: FormComponent {
    let id = UUID().uuidString
    let components: [any FormComponent]
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    
    init(spacing: CGFloat = 16, alignment: HorizontalAlignment = .leading, @FormComponentBuilder components: () -> [any FormComponent]) {
        self.spacing = spacing
        self.alignment = alignment
        self.components = components()
    }
}
