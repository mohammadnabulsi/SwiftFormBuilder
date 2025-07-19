//
//  FieldStyle.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//


import SwiftUI

public struct FieldStyle {
    public var labelFont: Font?
    public var labelColor: Color?
    public var backgroundColor: Color?
    public var borderColor: Color?
    public var borderWidth: CGFloat?
    public var cornerRadius: CGFloat?
    public var padding: EdgeInsets?
    public var isHidden: Bool
    public var isDisabled: Bool
    
    public init(
        labelFont: Font? = nil,
        labelColor: Color? = nil,
        backgroundColor: Color? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        padding: EdgeInsets? = nil,
        isHidden: Bool = false,
        isDisabled: Bool = false
    ) {
        self.labelFont = labelFont
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.isHidden = isHidden
        self.isDisabled = isDisabled
    }
}

// Add styling methods to form fields
public extension TextFormField {
    func style(_ style: FieldStyle) -> StyledTextFormField {
        return StyledTextFormField(field: self, style: style)
    }
    
    func hidden(_ hidden: Bool = true) -> StyledTextFormField {
        return StyledTextFormField(field: self, style: FieldStyle(isHidden: hidden))
    }
    
    func disabled(_ disabled: Bool = true) -> StyledTextFormField {
        return StyledTextFormField(field: self, style: FieldStyle(isDisabled: disabled))
    }
}

public extension DateFormField {
    func style(_ style: FieldStyle) -> StyledDateFormField {
        return StyledDateFormField(field: self, style: style)
    }
    
    func hidden(_ hidden: Bool = true) -> StyledDateFormField {
        return StyledDateFormField(field: self, style: FieldStyle(isHidden: hidden))
    }
    
    func disabled(_ disabled: Bool = true) -> StyledDateFormField {
        return StyledDateFormField(field: self, style: FieldStyle(isDisabled: disabled))
    }
}

// Styled field wrappers
public struct StyledTextFormField: FormField {
    public let field: TextFormField
    public let style: FieldStyle
    
    public var id: String { field.id }
    public var label: String { field.label }
    public var isRequired: Bool { field.isRequired }
    public var validationRules: [ValidationRule] { field.validationRules }
    public var placeholder: String? { field.placeholder }
}

public struct StyledDateFormField: FormField {
    public let field: DateFormField
    public let style: FieldStyle
    
    public var id: String { field.id }
    public var label: String { field.label }
    public var isRequired: Bool { field.isRequired }
    public var validationRules: [ValidationRule] { field.validationRules }
    public var dateRange: ClosedRange<Date>? { field.dateRange }
}
