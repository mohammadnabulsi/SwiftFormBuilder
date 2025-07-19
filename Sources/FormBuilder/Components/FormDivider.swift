//
//  FormDivider.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

public struct FormDivider: FormComponent {
    public let id = UUID().uuidString
    public let color: Color
    public let thickness: CGFloat
    public let padding: EdgeInsets
    
    public init(color: Color, thickness: CGFloat = 1, padding: EdgeInsets = EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)) {
        self.color = color
        self.thickness = thickness
        self.padding = padding
    }
}
