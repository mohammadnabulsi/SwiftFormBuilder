//
//  FormSpacer.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

struct FormSpacer: FormComponent {
    let id = UUID().uuidString
    let height: CGFloat?
    let width: CGFloat?
    
    init(height: CGFloat? = nil, width: CGFloat? = nil) {
        self.height = height
        self.width = width
    }
    
    init(_ size: CGFloat) {
        self.height = size
        self.width = size
    }
}
