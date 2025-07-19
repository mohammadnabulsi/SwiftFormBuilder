//
//  PickerFormField.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


public struct PickerFormField: FormField {
    public let id: String
    public let label: String
    public let isRequired: Bool
    public let validationRules: [ValidationRule]
    public let options: [String]
    
    public init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], options: [String] = []) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.options = options
    }
    
    public func label(_ text: String) -> PickerFormField {
        return PickerFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, options: options)
    }
    
    public func options(_ options: [String]) -> PickerFormField {
        return PickerFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, options: options)
    }
    
    public func required(_ required: Bool = true) -> PickerFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return PickerFormField(id: id, label: label, isRequired: required, validationRules: rules, options: options)
    }
}
