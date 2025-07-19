//
//  FormSection.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

// TODO: Check if needed
public struct FormSection: FormComponent {
    public var id: String = UUID().uuidString
    public let title: String?
    public let components: [any FormComponent]
    
    public init(_ title: String? = nil, @FormComponentBuilder components: () -> [any FormComponent]) {
        self.title = title
        self.components = components()
    }
    
    var allFields: [any FormField] {
        return extractFields(from: components)
    }
    
    private func extractFields(from components: [any FormComponent]) -> [any FormField] {
        var fields: [any FormField] = []
        
        for component in components {
            if let field = component as? any FormField {
                fields.append(field)
            } else if let row = component as? FormRow {
                fields.append(contentsOf: extractFields(from: row.components))
            } else if let column = component as? FormColumn {
                fields.append(contentsOf: extractFields(from: column.components))
            }
        }
        
        return fields
    }
}
