//
//  FieldValue.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

/// A type-safe enumeration representing different types of values that form fields can hold.
///
/// `FieldValue` provides a unified way to handle various data types within the FormBuilder
/// system while maintaining type safety and enabling easy conversion between different
/// representations. This enum supports all common form input types and provides convenient
/// methods for accessing and converting values.
///
/// ## Overview
///
/// The enum supports the following value types:
/// - **Text**: String-based input (text fields, text areas)
/// - **Number**: Numeric input (steppers, numeric text fields)
/// - **Boolean**: True/false values (toggles, checkboxes)
/// - **Date**: Date and time values (date pickers, time pickers)
/// - **Selection**: Single choice from options (pickers, dropdowns)
/// - **Multi-Selection**: Multiple choices (multi-select pickers, checkboxes)
/// - **None**: Empty or unset values
///
/// ## Type Safety Benefits
///
/// Using an enum provides several advantages:
/// - Compile-time type checking prevents value type mismatches
/// - Pattern matching enables exhaustive handling of all cases
/// - Easy conversion between different representations
/// - Consistent serialization and deserialization
///
/// ## Common Usage Patterns
///
/// ```swift
/// // Creating values
/// let emailValue = FieldValue.text("user@example.com")
/// let ageValue = FieldValue.number(25.0)
/// let newsletterValue = FieldValue.boolean(true)
/// let birthdateValue = FieldValue.date(Date())
/// 
/// // Pattern matching
/// switch fieldValue {
/// case .text(let string):
///     print("Text: \(string)")
/// case .number(let number):
///     print("Number: \(number)")
/// case .boolean(let bool):
///     print("Boolean: \(bool)")
/// case .none:
///     print("No value")
/// // ... handle other cases
/// }
/// 
/// // Using convenience properties
/// let displayText = fieldValue.stringValue
/// let isTrue = fieldValue.boolValue
/// ```
///
/// ## Serialization Support
///
/// The enum conforms to `Codable`, enabling easy serialization for:
/// - Form data persistence
/// - API communication
/// - State restoration
/// - Data export/import
///
/// - Note: All cases provide meaningful string representations through the `stringValue` property.
/// - Important: The `none` case represents an unset or empty field and should be handled appropriately in validation.
public enum FieldValue: Codable, Equatable {
    /// Represents textual input data.
    ///
    /// Used for text fields, text areas, and any string-based input. This is the most
    /// common field value type and covers simple text input, multi-line text, and
    /// formatted text input.
    ///
    /// ## Example Usage
    /// ```swift
    /// let name = FieldValue.text("John Doe")
    /// let description = FieldValue.text("A detailed description...")
    /// let email = FieldValue.text("user@example.com")
    /// ```
    case text(String)
    
    /// Represents numeric input data.
    ///
    /// Used for numeric fields including integers, decimals, currency, percentages,
    /// and any numerical input. Stored as `Double` to support both integer and
    /// decimal values with sufficient precision.
    ///
    /// ## Example Usage
    /// ```swift
    /// let age = FieldValue.number(25.0)
    /// let price = FieldValue.number(19.99)
    /// let percentage = FieldValue.number(85.5)
    /// ```
    case number(Double)
    
    /// Represents boolean (true/false) input data.
    ///
    /// Used for toggles, switches, checkboxes, and any binary choice input.
    /// This type clearly represents on/off or yes/no decisions.
    ///
    /// ## Example Usage
    /// ```swift
    /// let isSubscribed = FieldValue.boolean(true)
    /// let acceptsTerms = FieldValue.boolean(false)
    /// let isEnabled = FieldValue.boolean(true)
    /// ```
    case boolean(Bool)
    
    /// Represents date and time input data.
    ///
    /// Used for date pickers, time pickers, and datetime input fields.
    /// Stores the complete date and time information using Foundation's `Date` type.
    ///
    /// ## Example Usage
    /// ```swift
    /// let birthdate = FieldValue.date(Date())
    /// let appointmentTime = FieldValue.date(Calendar.current.date(from: components)!)
    /// let deadline = FieldValue.date(Date().addingTimeInterval(86400))
    /// ```
    case date(Date)
    
    /// Represents a single selection from multiple options.
    ///
    /// Used for dropdowns, radio buttons, segmented controls, and single-choice
    /// pickers. The string typically represents the identifier or display value
    /// of the selected option.
    ///
    /// ## Example Usage
    /// ```swift
    /// let country = FieldValue.selection("US")
    /// let priority = FieldValue.selection("High")
    /// let category = FieldValue.selection("Technology")
    /// ```
    case selection(String)
    
    /// Represents multiple selections from a set of options.
    ///
    /// Used for multi-select lists, checkbox groups, and tag selectors.
    /// The array contains the identifiers or display values of all selected options.
    ///
    /// ## Example Usage
    /// ```swift
    /// let skills = FieldValue.multiSelection(["Swift", "iOS", "UIKit"])
    /// let interests = FieldValue.multiSelection(["Music", "Sports", "Travel"])
    /// let notifications = FieldValue.multiSelection(["Email", "Push"])
    /// ```
    case multiSelection([String])
    
    /// Represents an empty or unset field value.
    ///
    /// Used when a field has no value, either initially or after being cleared.
    /// This case is important for validation logic and representing optional fields.
    ///
    /// ## Example Usage
    /// ```swift
    /// let emptyField = FieldValue.none
    /// 
    /// // Check for empty value
    /// if fieldValue == .none {
    ///     print("Field is empty")
    /// }
    /// ```
    case none
    
    /// A string representation of the field value suitable for display or text input.
    ///
    /// This computed property provides a consistent way to convert any field value
    /// to a string representation, useful for display in UI elements, logging,
    /// or text-based processing.
    ///
    /// ## Value Conversion Rules
    /// - `text`: Returns the string directly
    /// - `number`: Converts to string representation
    /// - `boolean`: Returns "true" or "false"
    /// - `date`: Returns formatted date string using default formatter
    /// - `selection`: Returns the selected value
    /// - `multiSelection`: Returns comma-separated values
    /// - `none`: Returns empty string
    ///
    /// ## Example
    /// ```swift
    /// let nameValue = FieldValue.text("John")
    /// print(nameValue.stringValue) // "John"
    /// 
    /// let ageValue = FieldValue.number(25.0)
    /// print(ageValue.stringValue) // "25.0"
    /// 
    /// let activeValue = FieldValue.boolean(true)
    /// print(activeValue.stringValue) // "true"
    /// ```
    public var stringValue: String {
        switch self {
        case .text(let value): return value
        case .number(let value): return String(value)
        case .boolean(let value): return String(value)
        case .date(let value): return DateFormatter().string(from: value)
        case .selection(let value): return value
        case .multiSelection(let values): return values.joined(separator: ", ")
        case .none: return ""
        }
    }
    
    /// A boolean representation of the field value indicating presence or truthiness.
    ///
    /// This computed property provides a consistent way to evaluate any field value
    /// as a boolean, useful for conditional logic, validation, and required field checking.
    ///
    /// ## Value Conversion Rules
    /// - `boolean`: Returns the boolean value directly
    /// - `text`: Returns `true` if string is not empty, `false` otherwise
    /// - `none`: Always returns `false`
    /// - All other cases: Return `true` (indicates presence of value)
    ///
    /// ## Example
    /// ```swift
    /// let emptyValue = FieldValue.none
    /// print(emptyValue.boolValue) // false
    /// 
    /// let textValue = FieldValue.text("Hello")
    /// print(textValue.boolValue) // true
    /// 
    /// let emptyTextValue = FieldValue.text("")
    /// print(emptyTextValue.boolValue) // false
    /// 
    /// let toggleValue = FieldValue.boolean(true)
    /// print(toggleValue.boolValue) // true
    /// ```
    public var boolValue: Bool {
        switch self {
        case .boolean(let value): return value
        case .text(let value): return !value.isEmpty
        case .none: return false
        default: return true
        }
    }
}
