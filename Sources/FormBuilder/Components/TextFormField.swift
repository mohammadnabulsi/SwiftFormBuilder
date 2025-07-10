//
//  TextFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

public struct TextFormField: FormField {
    public let id: String
    public let label: String
    public let placeholder: String?
    public let isRequired: Bool
    public let validationRules: [ValidationRule]
    
    public init(id: String, label: String? = nil, placeholder: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = []) {
        self.id = id
        self.label = label ?? id.capitalized
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.validationRules = validationRules
    }
    
    public func label(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: text, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules)
    }
    
    public func placeholder(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: text, isRequired: isRequired, validationRules: validationRules)
    }
    
    public func required(_ required: Bool = true) -> TextFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: required, validationRules: rules)
    }
    
    public func minLength(_ length: Int) -> TextFormField {
        let rule = MinLengthValidationRule(minLength: length)
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [rule])
    }
    
    public func email() -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [EmailValidationRule()])
    }
}
