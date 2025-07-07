//
//  RequiredValidationRule.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


struct RequiredValidationRule: ValidationRule {
    func validate(_ value: FieldValue) -> ValidationResult {
        switch value {
        case .text(let str):
            return ValidationResult(isValid: !str.isEmpty, errors: str.isEmpty ? [.required] : [])
        case .none:
            return ValidationResult(isValid: false, errors: [.required])
        default:
            return ValidationResult(isValid: true)
        }
    }
}
