//
//  FormField.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A protocol defining the contract for interactive form input fields.
///
/// `FormField` extends `FormComponent` to represent interactive elements that users can
/// modify to input data. This protocol defines the essential properties that all form
/// fields must provide, including labeling, validation, and requirement specifications.
///
/// ## Overview
///
/// Form fields are the primary interactive components in a form, allowing users to enter
/// and modify data. Each field provides:
/// - A human-readable label for accessibility and user guidance
/// - Validation rules to ensure data integrity
/// - Required field marking for form completion guidance
///
/// ## Field Types
///
/// The SwiftFormBuilder library provides several built-in field types:
/// - `TextFormField` - Single and multi-line text input
/// - `DateFormField` - Date and time selection
/// - `ToggleFormField` - Boolean on/off switches
/// - `PickerFormField` - Single and multi-selection pickers
/// - `StepperFormField` - Numeric input with increment/decrement controls
///
/// ## Example
///
/// ```swift
/// struct EmailField: FormField {
///     let id: String
///     let label: String = "Email Address"
///     let isRequired: Bool = true
///     let validationRules: [ValidationRule] = [
///         RequiredValidationRule(),
///         EmailValidationRule()
///     ]
/// }
/// ```
///
/// - Note: All form fields automatically participate in the form's validation and state management systems.
/// - Important: Fields marked as required will be validated for completion before form submission.
public protocol FormField: FormComponent {
    /// The display label for the form field.
    ///
    /// This text is shown to users to identify the purpose of the field.
    /// It should be descriptive and accessible, as it's used for:
    /// - Visual field labeling
    /// - Screen reader accessibility
    /// - Error message generation
    ///
    /// ## Example
    /// ```swift
    /// let label: String = "Email Address"
    /// ```
    var label: String { get }
    
    /// Indicates whether the field must be completed before form submission.
    ///
    /// Required fields are typically marked visually (often with an asterisk)
    /// and will prevent form submission if left empty. The form validation
    /// system automatically checks required fields during submission.
    ///
    /// ## Example
    /// ```swift
    /// let isRequired: Bool = true
    /// ```
    var isRequired: Bool { get }
    
    /// The validation rules applied to this field's input.
    ///
    /// Validation rules are evaluated whenever the field's value changes,
    /// providing immediate feedback to users. Multiple rules can be applied
    /// to a single field, and all must pass for the field to be considered valid.
    ///
    /// ## Common Validation Rules
    /// - `RequiredValidationRule` - Ensures the field is not empty
    /// - `EmailValidationRule` - Validates email address format
    /// - `MinLengthValidationRule` - Ensures minimum character count
    ///
    /// ## Example
    /// ```swift
    /// let validationRules: [ValidationRule] = [
    ///     RequiredValidationRule(),
    ///     MinLengthValidationRule(minLength: 8)
    /// ]
    /// ```
    var validationRules: [ValidationRule] { get }
}
