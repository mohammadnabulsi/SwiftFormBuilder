//
//  ToggleFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


struct ToggleFormField: FormField {
    let id: String
    let label: String
    let isRequired: Bool
    let validationRules: [ValidationRule]
    let defaultValue: Bool
    
    init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], defaultValue: Bool = false) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.defaultValue = defaultValue
    }
    
    func label(_ text: String) -> ToggleFormField {
        return ToggleFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, defaultValue: defaultValue)
    }
    
    func defaultValue(_ value: Bool) -> ToggleFormField {
        return ToggleFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, defaultValue: value)
    }
}
