//
//  FormDivider.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

struct FormDivider: FormComponent {
    let id = UUID().uuidString
    let color: Color
    let thickness: CGFloat
    let padding: EdgeInsets
    
    init(color: Color = Color(.separator), thickness: CGFloat = 1, padding: EdgeInsets = EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)) {
        self.color = color
        self.thickness = thickness
        self.padding = padding
    }
}
