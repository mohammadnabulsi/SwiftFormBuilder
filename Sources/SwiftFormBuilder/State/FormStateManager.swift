//
//  FormStateManager.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Combine
import SwiftUICore

/// A centralized state manager for handling form field values, validation, and overall form state.
///
/// `FormStateManager` serves as the backbone of the SwiftSwiftFormBuilder library's state management system,
/// providing a non-observable, thread-safe way to manage form data without triggering unnecessary
/// view updates. It coordinates between form fields, validation systems, and the overall form state.
///
/// ## Overview
///
/// The state manager provides several key capabilities:
/// - **Field State Management**: Tracks individual field states including values and validation results
/// - **Value Caching**: Maintains a centralized cache of all field values for efficient access
/// - **Validation Coordination**: Manages validation results and overall form validity
/// - **Communication**: Publishes form-level events through Combine publishers
///
/// ## Architecture
///
/// The state manager uses a non-observable pattern to avoid triggering view updates directly.
/// Instead, it relies on Combine publishers to notify interested parties of state changes:
/// - `formValidityPublisher` - Notifies when overall form validity changes
/// - `formValueChangedPublisher` - Notifies when any field value changes
///
/// ## Integration with SwiftUI
///
/// The state manager is automatically injected into the SwiftUI environment by `FormView`,
/// making it accessible to all form components through the environment:
///
/// ```swift
/// @Environment(\.formStateManager) private var stateManager
/// ```
///
/// ## Usage Pattern
///
/// While typically used internally by the SwiftSwiftFormBuilder system, you can interact with it directly:
///
/// ```swift
/// // Get current field value
/// let emailValue = stateManager.getValue(for: "email")
/// 
/// // Set field value programmatically
/// stateManager.setValue(.text("user@example.com"), for: "email")
/// 
/// // Get all form values
/// let allValues = stateManager.getAllValues()
/// ```
///
/// - Note: This class is designed to be non-observable to prevent excessive view updates during form interaction.
/// - Important: The state manager is thread-safe and can be accessed from any queue.
class FormStateManager {
    /// Internal storage for individual field states, keyed by field ID.
    private var fieldStates: [String: FieldState] = [:]
    
    /// Cached values for quick access, keyed by field ID.
    private var valuesCache: [String: FieldValue] = [:]
    
    /// Publisher that emits the overall validity state of the form.
    ///
    /// This publisher sends `true` when all fields in the form are valid (or have no validation rules),
    /// and `false` when any field has a validation error. Subscribers can use this to enable/disable
    /// submit buttons or show overall form status.
    ///
    /// ## Example Usage
    /// ```swift
    /// stateManager.formValidityPublisher
    ///     .sink { isValid in
    ///         submitButton.isEnabled = isValid
    ///     }
    ///     .store(in: &cancellables)
    /// ```
    let formValidityPublisher = PassthroughSubject<Bool, Never>()
    
    /// Publisher that emits the complete set of form values whenever any field changes.
    ///
    /// This publisher provides a dictionary of all current form values, allowing subscribers
    /// to react to any changes in the form data. This is useful for real-time form processing,
    /// auto-saving, or dependent field updates.
    ///
    /// ## Example Usage
    /// ```swift
    /// stateManager.formValueChangedPublisher
    ///     .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
    ///     .sink { values in
    ///         autoSaveForm(values)
    ///     }
    ///     .store(in: &cancellables)
    /// ```
    let formValueChangedPublisher = PassthroughSubject<[String: FieldValue], Never>()
    
    /// Retrieves or creates a field state for the specified field ID.
    ///
    /// This method implements lazy initialization, creating a new `FieldState` instance
    /// if one doesn't already exist for the given ID. This ensures that every field
    /// has a state object available when needed.
    ///
    /// - Parameter id: The unique identifier of the field
    /// - Returns: The `FieldState` instance for the specified field
    ///
    /// ## Example
    /// ```swift
    /// let emailFieldState = stateManager.getFieldState(for: "email")
    /// ```
    func getFieldState(for id: String) -> FieldState {
        if let existing = fieldStates[id] {
            return existing
        }
        let newState = FieldState(id: id)
        fieldStates[id] = newState
        return newState
    }
    
    /// Updates the value for a specific field and triggers related notifications.
    ///
    /// This method updates both the cached value and the field's state object,
    /// then notifies subscribers about the form value change. This is the primary
    /// method for updating field values programmatically.
    ///
    /// - Parameters:
    ///   - value: The new value to set for the field
    ///   - fieldId: The unique identifier of the field to update
    ///
    /// ## Side Effects
    /// - Updates the internal values cache
    /// - Updates the corresponding field state
    /// - Triggers `formValueChangedPublisher` with all current values
    ///
    /// ## Example
    /// ```swift
    /// stateManager.setValue(.text("john@example.com"), for: "email")
    /// ```
    func setValue(_ value: FieldValue, for fieldId: String) {
        valuesCache[fieldId] = value
        fieldStates[fieldId]?.value = value
        
        formValueChangedPublisher.send(valuesCache)
    }
    
    /// Retrieves the current value for a specific field.
    ///
    /// Returns the cached value for the specified field, or `.none` if no value
    /// has been set. This method provides efficient access to field values without
    /// going through the field state objects.
    ///
    /// - Parameter fieldId: The unique identifier of the field
    /// - Returns: The current `FieldValue` for the field, or `.none` if not set
    ///
    /// ## Example
    /// ```swift
    /// let currentEmail = stateManager.getValue(for: "email")
    /// if case .text(let emailString) = currentEmail {
    ///     print("Current email: \(emailString)")
    /// }
    /// ```
    func getValue(for fieldId: String) -> FieldValue {
        return valuesCache[fieldId] ?? .none
    }
    
    /// Returns a dictionary containing all current field values.
    ///
    /// This method provides access to the complete form state, useful for
    /// form submission, serialization, or bulk operations on form data.
    ///
    /// - Returns: A dictionary mapping field IDs to their current values
    ///
    /// ## Example
    /// ```swift
    /// let formData = stateManager.getAllValues()
    /// for (fieldId, value) in formData {
    ///     print("\(fieldId): \(value.stringValue)")
    /// }
    /// ```
    func getAllValues() -> [String: FieldValue] {
        return valuesCache
    }
    
    /// Updates the validation result for a specific field and checks overall form validity.
    ///
    /// This method updates the validation state for a field and triggers a check
    /// of the overall form validity. If the form's validity status changes, it
    /// notifies subscribers through the `formValidityPublisher`.
    ///
    /// - Parameters:
    ///   - result: The validation result to set, or `nil` to clear validation
    ///   - fieldId: The unique identifier of the field
    ///
    /// ## Side Effects
    /// - Updates the field's validation result
    /// - Triggers form validity check
    /// - May trigger `formValidityPublisher` if overall validity changes
    ///
    /// ## Example
    /// ```swift
    /// let emailResult = ValidationResult.invalid("Invalid email format")
    /// stateManager.setValidationResult(emailResult, for: "email")
    /// ```
    func setValidationResult(_ result: ValidationResult?, for fieldId: String) {
        fieldStates[fieldId]?.validationResult = result
        checkFormValidity()
    }
    
    /// Retrieves the current validation result for a specific field.
    ///
    /// Returns the validation result for the specified field, or `nil` if
    /// no validation has been performed or the field doesn't exist.
    ///
    /// - Parameter fieldId: The unique identifier of the field
    /// - Returns: The current `ValidationResult` for the field, or `nil`
    ///
    /// ## Example
    /// ```swift
    /// if let result = stateManager.getValidationResult(for: "email"),
    ///    !result.isValid {
    ///     print("Email validation error: \(result.errorMessage ?? "Unknown error")")
    /// }
    /// ```
    func getValidationResult(for fieldId: String) -> ValidationResult? {
        fieldStates[fieldId]?.validationResult
    }
    
    /// Evaluates the overall validity of the form based on all field validation results.
    ///
    /// This private method checks all field states to determine if the entire form
    /// is valid. A form is considered valid when all fields either pass validation
    /// or have no validation result (indicating no validation rules).
    ///
    /// ## Logic
    /// - Fields with `nil` validation results are considered valid
    /// - Fields with validation results must have `isValid == true`
    /// - All fields must be valid for the form to be valid
    ///
    /// ## Side Effects
    /// - Triggers `formValidityPublisher` with the calculated validity state
    private func checkFormValidity() {
        let isValid = fieldStates.values.allSatisfy { state in
            state.validationResult?.isValid ?? true
        }
        formValidityPublisher.send(isValid)
    }
}

/// Environment key for injecting the form state manager into the SwiftUI environment.
///
/// This private key enables the form state manager to be passed through the SwiftUI
/// environment hierarchy, making it accessible to all form components without explicit
/// parameter passing.
private struct FormStateManagerKey: @preconcurrency EnvironmentKey {
    /// The default form state manager instance used when none is explicitly provided.
    @MainActor
    static let defaultValue = FormStateManager()
}

/// Extension providing convenient access to the form state manager through SwiftUI's environment system.
///
/// This extension allows form components to access the state manager using the standard
/// SwiftUI environment pattern:
///
/// ```swift
/// @Environment(\.formStateManager) private var stateManager
/// ```
extension EnvironmentValues {
    /// The form state manager instance available in the current environment.
    ///
    /// This property provides access to the form's state manager, allowing components
    /// to read and write field values, validation results, and subscribe to form events.
    ///
    /// ## Usage in Views
    /// ```swift
    /// struct CustomFormField: View {
    ///     @Environment(\.formStateManager) private var stateManager
    ///     
    ///     var body: some View {
    ///         // Use stateManager to interact with form state
    ///     }
    /// }
    /// ```
    var formStateManager: FormStateManager {
        get { self[FormStateManagerKey.self] }
        set { self[FormStateManagerKey.self] = newValue }
    }
}
