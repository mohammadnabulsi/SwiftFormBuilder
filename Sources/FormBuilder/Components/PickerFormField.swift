//
//  PickerFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


struct PickerFormField: FormField {
    let id: String
    let label: String
    let isRequired: Bool
    let validationRules: [ValidationRule]
    let options: [String]
    
    init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], options: [String] = []) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.options = options
    }
    
    func label(_ text: String) -> PickerFormField {
        return PickerFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, options: options)
    }
    
    func options(_ options: [String]) -> PickerFormField {
        return PickerFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, options: options)
    }
    
    func required(_ required: Bool = true) -> PickerFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return PickerFormField(id: id, label: label, isRequired: required, validationRules: rules, options: options)
    }
}