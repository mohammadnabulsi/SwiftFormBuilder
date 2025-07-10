//
//  ValidationResult.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

public struct ValidationResult {
    public let isValid: Bool
    public let errors: [ValidationError]
    
    public init(isValid: Bool, errors: [ValidationError] = []) {
        self.isValid = isValid
        self.errors = errors
    }
}
