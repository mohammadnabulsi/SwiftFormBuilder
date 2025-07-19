//
//  FormSections.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

public struct FormComponents: FormContent {
    public let id: String = UUID().uuidString
    public let components: [any FormComponent]
    
    public init(@FormComponentBuilder components: () -> [any FormComponent]) {
        self.components = components()
    }
}
