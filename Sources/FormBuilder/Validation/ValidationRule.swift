//
//  ValidationRule.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

protocol ValidationRule {
    func validate(_ value: FieldValue) -> ValidationResult
}
