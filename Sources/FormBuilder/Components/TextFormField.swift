//
//  TextFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//


struct TextFormField: FormField {
    let id: String
    let label: String
    let placeholder: String?
    let isRequired: Bool
    let validationRules: [ValidationRule]
    
    init(id: String, label: String? = nil, placeholder: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = []) {
        self.id = id
        self.label = label ?? id.capitalized
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.validationRules = validationRules
    }
    
    func label(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: text, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules)
    }
    
    func placeholder(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: text, isRequired: isRequired, validationRules: validationRules)
    }
    
    func required(_ required: Bool = true) -> TextFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: required, validationRules: rules)
    }
    
    func minLength(_ length: Int) -> TextFormField {
        let rule = MinLengthValidationRule(minLength: length)
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [rule])
    }
    
    func email() -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [EmailValidationRule()])
    }
}
