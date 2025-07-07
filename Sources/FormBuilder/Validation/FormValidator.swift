//
//  FormValidator.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

class FormValidator: ObservableObject {
    func validate(field: any FormField, value: FieldValue, in formState: FormState) {
        var errors: [ValidationError] = []
        
        for rule in field.validationRules {
            let result = rule.validate(value)
            if !result.isValid {
                errors.append(contentsOf: result.errors)
            }
        }
        
        let validationResult = ValidationResult(isValid: errors.isEmpty, errors: errors)
        formState.validationResults[field.id] = validationResult
    }
    
    func validateAll(fields: [any FormField], in formState: FormState) {
        for field in fields {
            let value = formState.getValue(for: field.id)
            validate(field: field, value: value, in: formState)
        }
    }
}
