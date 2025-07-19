//
//  ValidationRule.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A protocol defining the contract for field validation logic.
///
/// `ValidationRule` provides a standardized interface for implementing validation logic
/// that can be applied to form fields. This protocol enables the creation of reusable,
/// composable validation rules that integrate seamlessly with the FormBuilder validation system.
///
/// ## Overview
///
/// Validation rules serve as the foundation of FormBuilder's validation system, providing:
/// - **Standardized Interface**: Consistent validation API across all rule types
/// - **Composability**: Multiple rules can be applied to a single field
/// - **Reusability**: Rules can be shared across different fields and forms
/// - **Type Safety**: Strongly typed validation results and error handling
///
/// ## Built-in Validation Rules
///
/// FormBuilder provides several built-in validation rules:
/// - `RequiredValidationRule` - Ensures fields are not empty
/// - `EmailValidationRule` - Validates email address format
/// - `MinLengthValidationRule` - Enforces minimum character count
/// - `MaxLengthValidationRule` - Enforces maximum character count
/// - `PatternValidationRule` - Regular expression pattern matching
///
/// ## Custom Validation Rules
///
/// You can create custom validation rules by conforming to this protocol:
///
/// ```swift
/// struct PasswordStrengthRule: ValidationRule {
///     func validate(_ value: FieldValue) -> ValidationResult {
///         guard case .text(let password) = value else {
///             return .invalid("Password is required")
///         }
///         
///         let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
///         let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
///         let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
///         let hasSpecialChar = password.range(of: "[!@#$%^&*]", options: .regularExpression) != nil
///         
///         if password.count >= 8 && hasUppercase && hasLowercase && hasNumber && hasSpecialChar {
///             return .valid
///         } else {
///             return .invalid("Password must be at least 8 characters with uppercase, lowercase, number, and special character")
///         }
///     }
/// }
/// ```
///
/// ## Validation Process
///
/// The validation process follows these steps:
/// 1. The field value is passed to each validation rule
/// 2. Each rule evaluates the value and returns a `ValidationResult`
/// 3. All validation results are combined to determine overall field validity
/// 4. Error messages are collected and displayed to the user
///
/// ## Usage in Fields
///
/// Validation rules are applied to fields using fluent API methods or directly:
///
/// ```swift
/// // Using fluent API
/// TextField("email")
///     .required()
///     .email()
///     .minLength(5)
/// 
/// // Using custom rules directly
/// TextField("password")
///     .validationRules([
///         RequiredValidationRule(),
///         PasswordStrengthRule()
///     ])
/// ```
///
/// ## Performance Considerations
///
/// - Validation rules should be lightweight and fast
/// - Complex validation should be debounced to avoid excessive computation
/// - Network-based validation should be performed asynchronously
/// - Rules should handle all possible `FieldValue` cases gracefully
///
/// - Note: Validation rules are evaluated every time a field's value changes, so they should be efficient.
/// - Important: Rules should handle type mismatches gracefully and provide meaningful error messages.
public protocol ValidationRule {
    /// Validates a field value and returns the validation result.
    ///
    /// This method is the core of the validation rule, taking a field value and
    /// determining whether it meets the rule's criteria. The method should handle
    /// all possible `FieldValue` cases and return appropriate validation results.
    ///
    /// ## Implementation Guidelines
    ///
    /// When implementing this method:
    /// - Handle all relevant `FieldValue` cases (text, number, boolean, etc.)
    /// - Provide clear, user-friendly error messages
    /// - Return `.valid` for passing validation
    /// - Return `.invalid(message)` for failing validation with descriptive error
    /// - Consider edge cases like empty values, nil values, and type mismatches
    ///
    /// ## Example Implementation
    ///
    /// ```swift
    /// func validate(_ value: FieldValue) -> ValidationResult {
    ///     switch value {
    ///     case .text(let text):
    ///         if text.isEmpty {
    ///             return .invalid("This field is required")
    ///         }
    ///         return .valid
    ///     case .none:
    ///         return .invalid("This field is required")
    ///     default:
    ///         return .valid // Other types considered valid for this rule
    ///     }
    /// }
    /// ```
    ///
    /// ## Error Message Best Practices
    ///
    /// Error messages should be:
    /// - Clear and specific about what's wrong
    /// - Actionable, telling users how to fix the issue
    /// - Consistent in tone and style
    /// - Localized for international applications
    ///
    /// - Parameter value: The field value to validate
    /// - Returns: A `ValidationResult` indicating success or failure with details
    func validate(_ value: FieldValue) -> ValidationResult
}
