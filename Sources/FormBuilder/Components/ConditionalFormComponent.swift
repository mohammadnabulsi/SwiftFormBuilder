//
//  ConditionalFormComponent.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct ConditionalFormComponent: FormComponent {
    public let id = UUID().uuidString
    public let condition: () -> Bool
    public let component: any FormComponent
    
    public init(condition: @escaping () -> Bool, @FormComponentBuilder component: () -> any FormComponent) {
        self.condition = condition
        self.component = component()
    }
}
