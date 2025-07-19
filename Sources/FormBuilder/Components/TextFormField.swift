//
//  TextFormField.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A form field component for text input with comprehensive configuration options.
///
/// `TextFormField` provides a flexible, configurable text input field that supports
/// various text input scenarios including single-line text, email addresses, passwords,
/// and other string-based input. The field uses a fluent API for easy configuration
/// and supports comprehensive validation rules.
///
/// ## Overview
///
/// Text fields are the most common form input component, handling:
/// - Simple text input (names, descriptions, comments)
/// - Email address input with validation
/// - Password input with security rules
/// - Formatted text input (phone numbers, IDs)
/// - Multi-line text input for longer content
///
/// ## Features
///
/// - **Fluent API**: Method chaining for easy configuration
/// - **Automatic Labeling**: Generates labels from field IDs if not specified
/// - **Validation Integration**: Built-in support for common validation rules
/// - **Placeholder Text**: Optional placeholder for user guidance
/// - **Required Field Support**: Automatic required field handling
///
/// ## Basic Usage
///
/// ```swift
/// // Simple text field
/// TextField("firstName")
///     .label("First Name")
///     .placeholder("Enter your first name")
///     .required()
/// 
/// // Email field with validation
/// TextField("email")
///     .label("Email Address")
///     .placeholder("user@example.com")
///     .required()
///     .email()
/// 
/// // Password field with minimum length
/// TextField("password")
///     .label("Password")
///     .required()
///     .minLength(8)
/// ```
///
/// ## Advanced Configuration
///
/// ```swift
/// TextField("description")
///     .label("Project Description")
///     .placeholder("Describe your project in detail...")
///     .required()
///     .minLength(10)
///     .maxLength(500)
/// ```
///
/// ## Integration with Forms
///
/// Text fields automatically integrate with the form's state management and
/// validation systems, providing real-time feedback and participating in
/// overall form validation.
///
/// - Note: All configuration methods return a new instance, supporting immutable design patterns.
/// - Important: The field ID should be unique within the form to ensure proper state management.
public struct TextFormField: FormField {
    /// The unique identifier for this text field.
    ///
    /// This identifier is used throughout the form system for state management,
    /// validation tracking, and value retrieval. It should be unique within
    /// the form context.
    public let id: String
    
    /// The display label for the text field.
    ///
    /// This text is shown to users to identify the purpose of the field.
    /// If not explicitly set, it defaults to a capitalized version of the field ID.
    /// The label is used for visual display and accessibility.
    public let label: String
    
    /// Optional placeholder text shown when the field is empty.
    ///
    /// Placeholder text provides guidance to users about the expected input format
    /// or content. It appears in a dimmed style when the field is empty and
    /// disappears when the user starts typing.
    public let placeholder: String?
    
    /// Indicates whether this field must be completed before form submission.
    ///
    /// Required fields are typically marked visually and will prevent form
    /// submission if left empty. The form validation system automatically
    /// checks required fields during submission.
    public let isRequired: Bool
    
    /// The array of validation rules applied to this field's input.
    ///
    /// Validation rules are evaluated whenever the field's value changes,
    /// providing immediate feedback to users. Multiple rules can be applied
    /// to a single field, and all must pass for the field to be considered valid.
    public let validationRules: [ValidationRule]
    
    /// Creates a new text form field with the specified configuration.
    ///
    /// This initializer creates a text field with the given parameters. Most parameters
    /// have sensible defaults, and the fluent API methods provide a more convenient
    /// way to configure fields.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the field
    ///   - label: Display label (defaults to capitalized ID)
    ///   - placeholder: Optional placeholder text
    ///   - isRequired: Whether the field is required (defaults to false)
    ///   - validationRules: Array of validation rules (defaults to empty)
    ///
    /// ## Example
    /// ```swift
    /// let emailField = TextFormField(
    ///     id: "email",
    ///     label: "Email Address",
    ///     placeholder: "user@example.com",
    ///     isRequired: true,
    ///     validationRules: [RequiredValidationRule(), EmailValidationRule()]
    /// )
    /// ```
    public init(id: String, label: String? = nil, placeholder: String? = nil, isRequired: Bool = false, validationRules: [ValidationRule] = []) {
        self.id = id
        self.label = label ?? id.capitalized
        self.placeholder = placeholder
        self.isRequired = isRequired
        self.validationRules = validationRules
    }
    
    /// Sets the display label for the text field.
    ///
    /// This method returns a new text field instance with the specified label.
    /// The label is displayed to users and used for accessibility purposes.
    ///
    /// - Parameter text: The label text to display
    /// - Returns: A new `TextFormField` instance with the specified label
    ///
    /// ## Example
    /// ```swift
    /// TextField("userEmail")
    ///     .label("Email Address")
    /// ```
    public func label(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: text, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules)
    }
    
    /// Sets the placeholder text for the text field.
    ///
    /// This method returns a new text field instance with the specified placeholder.
    /// Placeholder text provides guidance about the expected input format or content.
    ///
    /// - Parameter text: The placeholder text to display when field is empty
    /// - Returns: A new `TextFormField` instance with the specified placeholder
    ///
    /// ## Example
    /// ```swift
    /// TextField("email")
    ///     .placeholder("Enter your email address")
    /// ```
    public func placeholder(_ text: String) -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: text, isRequired: isRequired, validationRules: validationRules)
    }
    
    /// Marks the text field as required or optional.
    ///
    /// This method returns a new text field instance with the specified required status.
    /// Required fields automatically get a `RequiredValidationRule` added to their
    /// validation rules if one doesn't already exist.
    ///
    /// - Parameter required: Whether the field should be required (defaults to true)
    /// - Returns: A new `TextFormField` instance with the specified required status
    ///
    /// ## Example
    /// ```swift
    /// TextField("firstName")
    ///     .required()  // Mark as required
    /// 
    /// TextField("middleName")
    ///     .required(false)  // Mark as optional
    /// ```
    public func required(_ required: Bool = true) -> TextFormField {
        var rules = validationRules
        if required && !rules.contains(where: { $0 is RequiredValidationRule }) {
            rules.append(RequiredValidationRule())
        }
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: required, validationRules: rules)
    }
    
    /// Adds a minimum length validation rule to the text field.
    ///
    /// This method returns a new text field instance with a minimum length requirement.
    /// The field will be invalid if the entered text has fewer characters than specified.
    ///
    /// - Parameter length: The minimum number of characters required
    /// - Returns: A new `TextFormField` instance with minimum length validation
    ///
    /// ## Example
    /// ```swift
    /// TextField("password")
    ///     .minLength(8)  // Require at least 8 characters
    /// 
    /// TextField("description")
    ///     .minLength(10)  // Require at least 10 characters
    /// ```
    public func minLength(_ length: Int) -> TextFormField {
        let rule = MinLengthValidationRule(minLength: length)
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [rule])
    }
    
    /// Adds email format validation to the text field.
    ///
    /// This method returns a new text field instance with email validation.
    /// The field will be invalid if the entered text doesn't match a valid email format.
    /// This is commonly used for email address input fields.
    ///
    /// - Returns: A new `TextFormField` instance with email validation
    ///
    /// ## Example
    /// ```swift
    /// TextField("email")
    ///     .label("Email Address")
    ///     .required()
    ///     .email()  // Add email format validation
    /// ```
    public func email() -> TextFormField {
        return TextFormField(id: id, label: label, placeholder: placeholder, isRequired: isRequired, validationRules: validationRules + [EmailValidationRule()])
    }
}
