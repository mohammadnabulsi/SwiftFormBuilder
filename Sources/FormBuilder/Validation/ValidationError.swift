//
//  ValidationError.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

/// A structure representing a specific validation error with context and messaging.
///
/// `ValidationError` encapsulates information about a validation failure, providing
/// both human-readable error messages and structured error data. This structure is
/// used within `ValidationResult` to communicate specific validation failures to
/// users and the UI system.
///
/// ## Overview
///
/// Validation errors provide:
/// - **User-Friendly Messages**: Clear, actionable error descriptions
/// - **Error Context**: Specific information about what went wrong
/// - **Localization Support**: Built-in support for localized error messages
/// - **Structured Data**: Consistent error representation across the system
///
/// ## Usage Patterns
///
/// Validation errors are typically created by validation rules and consumed by:
/// - UI components for displaying error messages
/// - Logging systems for debugging validation issues
/// - Analytics systems for tracking validation failures
/// - Accessibility systems for announcing errors
///
/// ## Creating Validation Errors
///
/// ```swift
/// // Simple message-based error
/// let error = ValidationError(message: "This field is required")
/// 
/// // Error with additional context
/// let emailError = ValidationError(
///     message: "Please enter a valid email address",
///     field: "email",
///     code: "INVALID_EMAIL"
/// )
/// ```
///
/// ## Integration with ValidationResult
///
/// ```swift
/// // In a validation rule
/// func validate(_ value: FieldValue) -> ValidationResult {
///     guard case .text(let text) = value, !text.isEmpty else {
///         return ValidationResult(
///             isValid: false,
///             errors: [ValidationError(message: "This field is required")]
///         )
///     }
///     return ValidationResult.valid
/// }
/// ```
///
/// - Note: Error messages should be clear, specific, and actionable for users.
/// - Important: Consider localization requirements when creating error messages.
public struct ValidationError: Error, LocalizedError, Equatable {
    /// The human-readable error message describing the validation failure.
    ///
    /// This message is displayed to users and should be:
    /// - Clear and specific about what's wrong
    /// - Actionable, explaining how to fix the issue
    /// - Appropriate for the target audience
    /// - Localized for international applications
    public let message: String
    
    /// Optional field identifier associated with this error.
    ///
    /// This property helps identify which specific field caused the validation
    /// error, useful for programmatic error handling and debugging.
    public let field: String?
    
    /// Optional error code for programmatic error handling.
    ///
    /// Error codes provide a machine-readable way to identify specific types
    /// of validation errors, useful for analytics, testing, and automated
    /// error handling.
    public let code: String?
    
    /// Creates a new validation error with the specified message and optional context.
    ///
    /// - Parameters:
    ///   - message: The user-friendly error message
    ///   - field: Optional field identifier (defaults to nil)
    ///   - code: Optional error code for programmatic handling (defaults to nil)
    ///
    /// ## Example
    /// ```swift
    /// let error = ValidationError(
    ///     message: "Password must contain at least one uppercase letter",
    ///     field: "password",
    ///     code: "PASSWORD_MISSING_UPPERCASE"
    /// )
    /// ```
    public init(message: String, field: String? = nil, code: String? = nil) {
        self.message = message
        self.field = field
        self.code = code
    }
    
    /// The localized description of the error.
    ///
    /// This property conforms to the `LocalizedError` protocol and returns
    /// the error message. This enables automatic localization support when
    /// the message is properly localized.
    public var errorDescription: String? {
        return message
    }
}

/// Extension providing convenient factory methods for common validation errors.
extension ValidationError {
    /// Creates a required field validation error.
    ///
    /// This static property provides a standard error for required field validation
    /// failures, ensuring consistent messaging across the application.
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult(isValid: false, errors: [.required])
    /// ```
    public static let required = ValidationError(
        message: "This field is required",
        code: "FIELD_REQUIRED"
    )
    
    /// Creates an invalid email format validation error.
    ///
    /// This static property provides a standard error for email validation
    /// failures, ensuring consistent messaging for email format issues.
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult(isValid: false, errors: [.invalidEmail])
    /// ```
    public static let invalidEmail = ValidationError(
        message: "Please enter a valid email address",
        code: "INVALID_EMAIL_FORMAT"
    )
    
    /// Creates a minimum length validation error.
    ///
    /// This static method provides a standard error for minimum length validation
    /// failures, with the specific length requirement included in the message.
    ///
    /// - Parameter length: The minimum required length
    /// - Returns: A validation error for minimum length requirement
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult(isValid: false, errors: [.minLength(8)])
    /// ```
    public static func minLength(_ length: Int) -> ValidationError {
        return ValidationError(
            message: "Must be at least \(length) characters",
            code: "MIN_LENGTH_\(length)"
        )
    }
    
    /// Creates a maximum length validation error.
    ///
    /// This static method provides a standard error for maximum length validation
    /// failures, with the specific length limit included in the message.
    ///
    /// - Parameter length: The maximum allowed length
    /// - Returns: A validation error for maximum length requirement
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult(isValid: false, errors: [.maxLength(100)])
    /// ```
    public static func maxLength(_ length: Int) -> ValidationError {
        return ValidationError(
            message: "Must be no more than \(length) characters",
            code: "MAX_LENGTH_\(length)"
        )
    }
    
    /// Creates a custom validation error with a specific message.
    ///
    /// This static method provides a way to create validation errors with
    /// custom messages for specialized validation scenarios.
    ///
    /// - Parameter message: The custom error message
    /// - Returns: A validation error with the custom message
    ///
    /// ## Example
    /// ```swift
    /// return ValidationResult(isValid: false, errors: [.custom("Username already exists")])
    /// ```
    public static func custom(_ message: String) -> ValidationError {
        return ValidationError(
            message: message,
            code: "CUSTOM_ERROR"
        )
    }
}
