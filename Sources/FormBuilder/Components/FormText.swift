//
//  FormText.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

public struct FormText: FormComponent {
    public let id = UUID().uuidString
    public let text: String
    public let font: Font
    public let color: Color
    public let alignment: TextAlignment
    
    public init(_ text: String, font: Font = .body, color: Color = .primary, alignment: TextAlignment = .leading) {
        self.text = text
        self.font = font
        self.color = color
        self.alignment = alignment
    }
}
