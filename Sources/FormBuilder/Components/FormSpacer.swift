//
//  FormSpacer.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUICore

public struct FormSpacer: FormComponent {
    public let id = UUID().uuidString
    public let height: CGFloat?
    public let width: CGFloat?
    
    public init(height: CGFloat? = nil, width: CGFloat? = nil) {
        self.height = height
        self.width = width
    }
    
    public init(_ size: CGFloat) {
        self.height = size
        self.width = size
    }
}
