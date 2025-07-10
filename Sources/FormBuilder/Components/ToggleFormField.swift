//
//  ToggleFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


public struct ToggleFormField: FormField {
    public let id: String
    public let label: String
    public let isRequired: Bool
    public let validationRules: [ValidationRule]
    public let defaultValue: Bool
    
    public init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], defaultValue: Bool = false) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.defaultValue = defaultValue
    }
    
    public func label(_ text: String) -> ToggleFormField {
        return ToggleFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, defaultValue: defaultValue)
    }
    
    public func defaultValue(_ value: Bool) -> ToggleFormField {
        return ToggleFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, defaultValue: value)
    }
}
