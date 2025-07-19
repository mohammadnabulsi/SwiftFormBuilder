//
//  FieldState.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Combine

/// An observable state container for individual form fields.
///
/// `FieldState` represents the complete state of a single form field, including its current
/// value and validation status. This class uses SwiftUI's `@Published` property wrappers to
/// enable reactive updates when field state changes, allowing the UI to automatically
/// respond to value and validation changes.
///
/// ## Overview
///
/// Each form field gets its own `FieldState` instance that tracks:
/// - **Current Value**: The field's current input value
/// - **Validation Result**: The result of applying validation rules to the current value
/// - **Field Identity**: A unique identifier linking the state to its corresponding field
///
/// ## Integration with State Management
///
/// Field states are managed by the `FormStateManager` and are created lazily when fields
/// are first accessed. The observable nature of this class ensures that any UI components
/// observing the field will automatically update when the state changes.
///
/// ## Reactive Pattern
///
/// The class follows SwiftUI's reactive pattern using `@Published` properties:
/// - Views can observe changes using `@ObservedObject` or `@StateObject`
/// - Property changes automatically trigger view updates
/// - Combine publishers are available for custom reactive logic
///
/// ## Example Usage
///
/// ```swift
/// // Typically created and managed by FormStateManager
/// let fieldState = FieldState(id: "email")
/// 
/// // Update value (triggers UI update)
/// fieldState.value = .text("user@example.com")
/// 
/// // Update validation result (triggers UI update)
/// fieldState.validationResult = .valid
/// ```
///
/// ## SwiftUI Integration
///
/// ```swift
/// struct FieldView: View {
///     @ObservedObject var fieldState: FieldState
///     
///     var body: some View {
///         VStack {
///             TextField("Email", text: binding)
///             if let result = fieldState.validationResult, !result.isValid {
///                 Text(result.errorMessage ?? "Invalid")
///                     .foregroundColor(.red)
///             }
///         }
///     }
///     
///     private var binding: Binding<String> {
///         Binding(
///             get: { fieldState.value.stringValue },
///             set: { fieldState.value = .text($0) }
///         )
///     }
/// }
/// ```
///
/// - Note: Field states are automatically created by the FormStateManager when fields are accessed.
/// - Important: The observable nature means this class should only be used on the main thread.
class FieldState: ObservableObject {
    /// The unique identifier for the field this state represents.
    ///
    /// This identifier links the state object to its corresponding form field definition
    /// and is used by the form state manager to organize and retrieve field states.
    /// The ID should match the field's identifier in the form definition.
    ///
    /// ## Example
    /// ```swift
    /// let emailState = FieldState(id: "email")
    /// print(emailState.id) // "email"
    /// ```
    let id: String
    
    /// The current value of the form field.
    ///
    /// This published property holds the field's current input value and automatically
    /// notifies observers when changed. The value type can represent different kinds
    /// of input data (text, numbers, dates, etc.) through the `FieldValue` enum.
    ///
    /// ## Automatic UI Updates
    /// When this value changes, any SwiftUI views observing this `FieldState` will
    /// automatically re-render to reflect the new value.
    ///
    /// ## Example
    /// ```swift
    /// // Set text value
    /// fieldState.value = .text("Hello World")
    /// 
    /// // Set boolean value
    /// fieldState.value = .boolean(true)
    /// 
    /// // Set date value
    /// fieldState.value = .date(Date())
    /// ```
    @Published var value: FieldValue = .none
    
    /// The current validation result for the field.
    ///
    /// This published property holds the result of applying validation rules to the
    /// current field value. It can be `nil` (no validation performed), `.valid`
    /// (validation passed), or `.invalid` (validation failed with error message).
    ///
    /// ## Automatic UI Updates
    /// When this validation result changes, any SwiftUI views observing this
    /// `FieldState` will automatically update to show or hide validation messages.
    ///
    /// ## Validation States
    /// - `nil` - No validation has been performed or no validation rules exist
    /// - `.valid` - All validation rules passed
    /// - `.invalid(message)` - One or more validation rules failed
    ///
    /// ## Example
    /// ```swift
    /// // Set validation success
    /// fieldState.validationResult = .valid
    /// 
    /// // Set validation failure
    /// fieldState.validationResult = .invalid("Email format is invalid")
    /// 
    /// // Clear validation
    /// fieldState.validationResult = nil
    /// ```
    @Published var validationResult: ValidationResult?
    
    /// Creates a new field state with the specified identifier.
    ///
    /// Initializes a field state with the given ID and default values. The field
    /// starts with no value (`.none`) and no validation result (`nil`).
    ///
    /// - Parameter id: The unique identifier for the field
    ///
    /// ## Example
    /// ```swift
    /// let emailFieldState = FieldState(id: "email")
    /// let passwordFieldState = FieldState(id: "password")
    /// ```
    init(id: String) {
        self.id = id
    }
}
