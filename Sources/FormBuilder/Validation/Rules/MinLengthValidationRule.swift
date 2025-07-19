//
//  MinLengthValidationRule.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


struct MinLengthValidationRule: ValidationRule {
    let minLength: Int
    
    func validate(_ value: FieldValue) -> ValidationResult {
        guard case .text(let text) = value else {
            return ValidationResult(isValid: false, errors: [.minLength(minLength)])
        }
        
        let isValid = text.count >= minLength
        return ValidationResult(isValid: isValid, errors: isValid ? [] : [.minLength(minLength)])
    }
}
