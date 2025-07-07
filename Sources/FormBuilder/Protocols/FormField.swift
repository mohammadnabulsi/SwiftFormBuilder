//
//  FormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

protocol FormField: FormComponent {
    var label: String { get }
    var isRequired: Bool { get }
    var validationRules: [ValidationRule] { get }
}
