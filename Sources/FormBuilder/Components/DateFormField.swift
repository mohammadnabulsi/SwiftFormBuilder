//
//  DateFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

public struct DateFormField: FormField {
    public let id: String
    public let label: String
    public let isRequired: Bool
    public let validationRules: [ValidationRule]
    public let dateRange: ClosedRange<Date>?
    
    public init(id: String, label: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = [], dateRange: ClosedRange<Date>? = nil) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.dateRange = dateRange
    }
    
    public func label(_ text: String) -> DateFormField {
        return DateFormField(id: id, label: text, isRequired: isRequired, validationRules: validationRules, dateRange: dateRange)
    }
    
    public func required(_ required: Bool = true) -> DateFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return DateFormField(id: id, label: label, isRequired: required, validationRules: rules, dateRange: dateRange)
    }
    
    public func maxDate(_ date: Date) -> DateFormField {
        let range = Date.distantPast...date
        return DateFormField(id: id, label: label, isRequired: isRequired, validationRules: validationRules, dateRange: range)
    }
}
