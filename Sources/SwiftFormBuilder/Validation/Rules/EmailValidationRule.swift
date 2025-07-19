//
//  EmailValidationRule.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

struct EmailValidationRule: ValidationRule {
    func validate(_ value: FieldValue) -> ValidationResult {
        guard case .text(let email) = value else {
            return ValidationResult(isValid: false, errors: [.invalidEmail])
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isValid = predicate.evaluate(with: email)
        
        return ValidationResult(isValid: isValid, errors: isValid ? [] : [.invalidEmail])
    }
}
