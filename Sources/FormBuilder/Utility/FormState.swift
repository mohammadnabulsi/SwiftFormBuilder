//
//  FormState.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

class FormState: ObservableObject {
    @Published var values: [String: FieldValue] = [:]
    @Published var validationResults: [String: ValidationResult] = [:]
    @Published var isSubmitting: Bool = false
    @Published var isDirty: Bool = false
    
    var isValid: Bool {
        return validationResults.values.allSatisfy { $0.isValid }
    }
    
    func setValue(_ value: FieldValue, for fieldId: String) {
        values[fieldId] = value
        isDirty = true
    }
    
    func getValue(for fieldId: String) -> FieldValue {
        return values[fieldId] ?? .none
    }
}
