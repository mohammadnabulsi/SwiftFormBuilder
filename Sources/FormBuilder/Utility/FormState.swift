//
//  FormState.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation
import Combine

class FormState: ObservableObject {
    private var values: [String: FieldValue] = [:]
    private var validationResults: [String: ValidationResult] = [:]
    @Published var isValid: Bool = false
    
    func setValue(_ value: FieldValue, for fieldId: String) {
        values[fieldId] = value
    }
    
    func getValue(for fieldId: String) -> FieldValue {
        return values[fieldId] ?? .none
    }
    
    func setValidationResult(_ value: ValidationResult?, for fieldId: String) {
        validationResults[fieldId] = value
        let tmpIsValid = validationResults.values.allSatisfy { $0.isValid }
        if tmpIsValid != isValid {
            isValid = tmpIsValid
        }
    }
    
    public func getValidationResult(for fieldId: String) -> ValidationResult? {
        validationResults[fieldId]
    }
}
