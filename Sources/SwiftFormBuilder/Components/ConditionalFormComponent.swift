//
//  ConditionalFormComponent.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct ConditionalFormComponent: FormComponent {
    public let id = UUID().uuidString
    public let condition: ([String: FieldValue]) -> Bool
    public let components: [any FormComponent]
    
    public init(condition: @escaping ([String: FieldValue]) -> Bool, @FormComponentBuilder components: () -> [any FormComponent]) {
        self.condition = condition
        self.components = components()
    }
}
