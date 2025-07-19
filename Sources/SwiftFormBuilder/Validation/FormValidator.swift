//
//  FormValidator.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

class FormValidator: ObservableObject {
    private var validationCache: [String: ValidationResult] = [:]
    
    func validate(field: any FormField, value: FieldValue) -> ValidationResult {
        let cacheKey = "\(field.id)-\(value.stringValue)"
        
        if let cached = validationCache[cacheKey] {
            return cached
        }
        
        var errors: [ValidationError] = []
        
        for rule in field.validationRules {
            let result = rule.validate(value)
            if !result.isValid {
                errors.append(contentsOf: result.errors)
            }
        }
        
        let result = ValidationResult(isValid: errors.isEmpty, errors: errors)
        validationCache[cacheKey] = result
        
        // Limit cache size
        if validationCache.count > 100 {
            validationCache.removeAll()
        }
        
        return result
    }
}
