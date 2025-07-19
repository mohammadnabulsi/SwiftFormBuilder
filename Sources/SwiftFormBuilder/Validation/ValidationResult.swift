//
//  ValidationResult.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A structure representing the result of field validation operations.
///
/// `ValidationResult` encapsulates the outcome of applying validation rules to a field value,
/// providing both a boolean validity indicator and detailed error information. This structure
/// is used throughout the SwiftSwiftFormBuilder validation system to communicate validation outcomes
/// between validation rules, field states, and UI components.
///
/// ## Overview
///
/// The validation result provides:
/// - **Validity Status**: A simple boolean indicating pass/fail status
/// - **Error Details**: Comprehensive error information for failed validations
/// - **Multiple Error Support**: Ability to accumulate multiple validation errors
///
/// ## Usage Patterns
///
/// Validation results are typically created by validation rules and consumed by:
/// - Form fields for displaying validation status
/// - UI components for showing error messages
/// - Form state manager for tracking overall form validity
///
/// ## Creating Validation Results
///
/// ```swift
/// // Success case
/// let successResult = ValidationResult(isValid: true)
/// 
/// // Failure case with single error
/// let failureResult = ValidationResult(
///     isValid: false,
///     errors: [ValidationError(message: "Email format is invalid")]
/// )
/// 
/// // Multiple errors
/// let multipleErrorsResult = ValidationResult(
///     isValid: false,
///     errors: [
///         ValidationError(message: "Field is required"),
///         ValidationError(message: "Must be at least 8 characters")
///     ]
/// )
/// ```
///
/// ## Integration with UI
///
/// ```swift
/// if let result = fieldState.validationResult {
///     if result.isValid {
///         showSuccessIndicator()
///     } else {
///         showErrorMessages(result.errors.map { $0.message })
///     }
/// }
/// ```
///
/// - Note: A validation result with `isValid: true` may still contain errors for informational purposes.
/// - Important: The `errors` array provides detailed information about what validation rules failed.
public struct ValidationResult : Sendable{
    /// Indicates whether the validation passed or failed.
    ///
    /// This boolean property provides a quick way to determine if the validated
    /// value meets all validation requirements. When `true`, the value passed
    /// all validation rules; when `false`, one or more validation rules failed.
    ///
    /// ## Usage
    /// ```swift
    /// if validationResult.isValid {
    ///     enableSubmitButton()
    /// } else {
    ///     showValidationErrors()
    /// }
    /// ```
    public let isValid: Bool
    
    /// An array of validation errors that occurred during validation.
    ///
    /// This array contains detailed information about validation failures,
    /// including specific error messages that can be displayed to users.
    /// Even when `isValid` is `true`, this array might contain warnings
    /// or informational messages.
    ///
    /// ## Common Use Cases
    /// - Displaying specific error messages to users
    /// - Logging validation failures for debugging
    /// - Providing detailed feedback about what needs to be corrected
    ///
    /// ## Example
    /// ```swift
    /// for error in validationResult.errors {
    ///     print("Validation error: \(error.message)")
    /// }
    /// ```
    public let errors: [ValidationError]
    
    /// Creates a new validation result with the specified validity and errors.
    ///
    /// This initializer allows creating validation results for both success and
    /// failure cases. The errors parameter defaults to an empty array, making
    /// it convenient to create success results.
    ///
    /// - Parameters:
    ///   - isValid: Whether the validation passed
    ///   - errors: Array of validation errors (defaults to empty array)
    ///
    /// ## Examples
    /// ```swift
    /// // Success result
    /// let success = ValidationResult(isValid: true)
    /// 
    /// // Failure result with error
    /// let failure = ValidationResult(
    ///     isValid: false,
    ///     errors: [ValidationError(message: "Invalid input")]
    /// )
    /// ```
    public init(isValid: Bool, errors: [ValidationError] = []) {
        self.isValid = isValid
        self.errors = errors
    }
}

/// Extension providing convenient factory methods for common validation result scenarios.
extension ValidationResult {
    /// Creates a successful validation result with no errors.
    ///
    /// This static property provides a convenient way to create validation
    /// results for cases where validation passes without any issues.
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult.valid
    /// ```
    public static let valid = ValidationResult(isValid: true)
    
    /// Creates a failed validation result with a single error message.
    ///
    /// This static method provides a convenient way to create validation
    /// results for simple failure cases with a single error message.
    ///
    /// - Parameter message: The error message describing the validation failure
    /// - Returns: A validation result with `isValid: false` and the specified error
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult.invalid("Email address is required")
    /// ```
    public static func invalid(_ message: String) -> ValidationResult {
        return ValidationResult(
            isValid: false,
            errors: [ValidationError(message: message)]
        )
    }
    
    /// The first error message from the errors array, if any.
    ///
    /// This computed property provides convenient access to the primary error
    /// message when you only need to display a single error. Returns `nil`
    /// if there are no errors.
    ///
    /// ## Example
    /// ```swift
    /// if let errorMessage = validationResult.errorMessage {
    ///     showError(errorMessage)
    /// }
    /// ```
    public var errorMessage: String? {
        return errors.first?.message
    }
}
