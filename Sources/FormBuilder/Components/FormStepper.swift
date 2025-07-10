//
//  FormStepper.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct FormStepper: FormComponent {
    public let id = UUID().uuidString
    public let steps: [FormStep]
    public let currentStep: Int
    
    public struct FormStep {
        public let title: String
        public let components: [any FormComponent]
        public let isValid: (FormState) -> Bool
        
        public init(title: String, isValid: @escaping (FormState) -> Bool = { _ in true }, @FormComponentBuilder components: () -> [any FormComponent]) {
            self.title = title
            self.isValid = isValid
            self.components = components()
        }
    }
    
    public init(currentStep: Int = 0, steps: [FormStep]) {
        self.currentStep = currentStep
        self.steps = steps
    }
}
