//
//  DateFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

struct DateFormField: FormField {
    let id: String
    let label: String
    let isRequired: Bool
    let validationRules: [ValidationRule]
    let dateRange: ClosedRange<Date>?
    
    init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], dateRange: ClosedRange<Date>? = nil) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.dateRange = dateRange
    }
    
    func label(_ text: String) -> DateFormField {
        return DateFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, dateRange: dateRange)
    }
    
    func required(_ required: Bool = true) -> DateFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return DateFormField(id: id, label: label, isRequired: required, validationRules: rules, dateRange: dateRange)
    }
    
    func maxDate(_ date: Date) -> DateFormField {
        let range = Date.distantPast...date
        return DateFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, dateRange: range)
    }
}
