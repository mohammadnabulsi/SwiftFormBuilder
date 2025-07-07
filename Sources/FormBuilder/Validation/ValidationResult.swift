//
//  ValidationResult.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

struct ValidationResult {
    let isValid: Bool
    let errors: [ValidationError]
    
    init(isValid: Bool, errors: [ValidationError] = []) {
        self.isValid = isValid
        self.errors = errors
    }
}
