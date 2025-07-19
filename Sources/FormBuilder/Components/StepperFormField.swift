//
//  StepperFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct StepperFormField: FormField {
    public let id: String
    public let label: String
    public let isRequired: Bool
    public let validationRules: [ValidationRule]
    public let range: ClosedRange<Double>?
    public let step: Double
    public let defaultValue: Double
    public let format: String?
    
    public init(
        id: String,
        label: String? = nil,
        isRequired: Bool = false,
        validationRules: [ValidationRule] = [],
        range: ClosedRange<Double>? = nil,
        step: Double = 1.0,
        defaultValue: Double = 0.0,
        format: String? = nil
    ) {
        self.id = id
        self.label = label ?? id.capitalized
        self.isRequired = isRequired
        self.validationRules = validationRules
        self.range = range
        self.step = step
        self.defaultValue = defaultValue
        self.format = format
    }
    
    public func label(_ text: String) -> StepperFormField {
        return StepperFormField(
            id: id,
            label: text,
            isRequired: isRequired,
            validationRules: validationRules,
            range: range,
            step: step,
            defaultValue: defaultValue,
            format: format
        )
    }
    
    public func required(_ required: Bool = true) -> StepperFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return StepperFormField(
            id: id,
            label: label,
            isRequired: required,
            validationRules: rules,
            range: range,
            step: step,
            defaultValue: defaultValue,
            format: format
        )
    }
    
    public func range(_ range: ClosedRange<Double>) -> StepperFormField {
        return StepperFormField(
            id: id,
            label: label,
            isRequired: isRequired,
            validationRules: validationRules,
            range: range,
            step: step,
            defaultValue: defaultValue,
            format: format
        )
    }
    
    public func step(_ step: Double) -> StepperFormField {
        return StepperFormField(
            id: id,
            label: label,
            isRequired: isRequired,
            validationRules: validationRules,
            range: range,
            step: step,
            defaultValue: defaultValue,
            format: format
        )
    }
    
    public func defaultValue(_ value: Double) -> StepperFormField {
        return StepperFormField(
            id: id,
            label: label,
            isRequired: isRequired,
            validationRules: validationRules,
            range: range,
            step: step,
            defaultValue: value,
            format: format
        )
    }
    
    public func format(_ format: String) -> StepperFormField {
        return StepperFormField(
            id: id,
            label: label,
            isRequired: isRequired,
            validationRules: validationRules,
            range: range,
            step: step,
            defaultValue: defaultValue,
            format: format
        )
    }
}
