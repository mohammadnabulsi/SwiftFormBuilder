//
//  FormValidator.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

class FormValidator: ObservableObject {
    func validate(field: any FormField, value: FieldValue) -> ValidationResult {
        var errors: [ValidationError] = []
        
        for rule in field.validationRules {
//            let result = rule.validate(value)
//            if !result.isValid {
//                errors.append(contentsOf: result.errors)
//            }
        }
        
        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }
}
