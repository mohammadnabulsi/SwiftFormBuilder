//
//  FormText.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

struct FormText: FormComponent {
    let id = UUID().uuidString
    let text: String
    let font: Font
    let color: Color
    let alignment: TextAlignment
    
    init(_ text: String, font: Font = .body, color: Color = .primary, alignment: TextAlignment = .leading) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
    }
}
