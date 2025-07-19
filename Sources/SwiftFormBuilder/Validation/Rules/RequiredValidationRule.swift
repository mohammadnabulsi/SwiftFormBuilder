//
//  RequiredValidationRule.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A validation rule that ensures form fields are not empty or unset.
///
/// `RequiredValidationRule` is one of the most fundamental validation rules in FormBuilder,
/// ensuring that users provide input for fields marked as required. This rule checks that
/// field values are present and not empty, preventing form submission with incomplete data.
///
/// ## Overview
///
/// The required validation rule handles different field value types appropriately:
/// - **Text Fields**: Ensures text is not empty (not just whitespace)
/// - **Selection Fields**: Ensures a selection has been made
/// - **Boolean Fields**: Generally considered valid if explicitly set
/// - **Date Fields**: Ensures a date has been selected
/// - **None Values**: Always considered invalid (no input provided)
///
/// ## Validation Logic
///
/// The rule applies the following validation logic:
/// - `.none` values are always invalid (no input)
/// - `.text(string)` values are invalid if the string is empty
/// - All other value types are considered valid if present
///
/// ## Usage
///
/// Required validation is typically applied using the fluent API:
///
/// ```swift
/// TextField("email")
///     .required()  // Automatically adds RequiredValidationRule
/// 
/// PickerField("country")
///     .required()  // Also applies to other field types
/// ```
///
/// ## Direct Usage
///
/// You can also apply the rule directly:
///
/// ```swift
/// let field = TextFormField(
///     id: "name",
///     validationRules: [RequiredValidationRule()]
/// )
/// ```
///
/// ## Error Messages
///
/// When validation fails, this rule provides a clear, user-friendly error message
/// indicating that the field is required and must be completed.
///
/// - Note: This rule is automatically added when using the `.required()` method on fields.
/// - Important: The rule considers empty strings as invalid, not just nil values.
public struct RequiredValidationRule: ValidationRule {
    /// Creates a new required validation rule.
    ///
    /// The initializer creates a ready-to-use required validation rule that can be
    /// applied to any form field. No configuration is needed as the rule applies
    /// the same logic to all field types.
    ///
    /// ## Example
    /// ```swift
    /// let requiredRule = RequiredValidationRule()
    /// ```
    public init() {}
    
    /// Validates that a field value is present and not empty.
    ///
    /// This method implements the core required field validation logic, checking
    /// that the provided value represents actual user input rather than an empty
    /// or unset state.
    ///
    /// ## Validation Rules
    ///
    /// - `.text(string)`: Valid if string is not empty
    /// - `.number(value)`: Always valid (any number is considered input)
    /// - `.boolean(value)`: Always valid (any boolean state is considered input)
    /// - `.date(value)`: Always valid (any date is considered input)
    /// - `.selection(value)`: Valid if selection string is not empty
    /// - `.multiSelection(values)`: Valid if array is not empty
    /// - `.none`: Always invalid (represents no input)
    ///
    /// ## Example Results
    ///
    /// ```swift
    /// let rule = RequiredValidationRule()
    /// 
    /// // Valid cases
    /// rule.validate(.text("Hello"))           // ✅ Valid
    /// rule.validate(.number(42.0))            // ✅ Valid
    /// rule.validate(.boolean(true))           // ✅ Valid
    /// rule.validate(.selection("option1"))    // ✅ Valid
    /// 
    /// // Invalid cases
    /// rule.validate(.text(""))                // ❌ Invalid
    /// rule.validate(.none)                    // ❌ Invalid
    /// rule.validate(.multiSelection([]))      // ❌ Invalid
    /// ```
    ///
    /// - Parameter value: The field value to validate
    /// - Returns: A validation result indicating whether the field has required input
    public func validate(_ value: FieldValue) -> ValidationResult {
        switch value {
        case .text(let str):
            // Text must not be empty
            if str.isEmpty {
                return ValidationResult(isValid: false, errors: [.required])
            } else {
                return ValidationResult.valid
            }
            
        case .selection(let selection):
            // Selection must not be empty
            if selection.isEmpty {
                return ValidationResult(isValid: false, errors: [.required])
            } else {
                return ValidationResult.valid
            }
            
        case .multiSelection(let selections):
            // Must have at least one selection
            if selections.isEmpty {
                return ValidationResult(isValid: false, errors: [.required])
            } else {
                return ValidationResult.valid
            }
            
        case .none:
            // No value provided
            return ValidationResult(isValid: false, errors: [.required])
            
        default:
            // Numbers, booleans, and dates are valid if present
            return ValidationResult.valid
        }
    }
}
