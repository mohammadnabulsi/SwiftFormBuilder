//
//  FormComponent.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// The base protocol for all form components in the SwiftSwiftFormBuilder library.
///
/// `FormComponent` serves as the foundation for all elements that can be included in a form,
/// providing a unique identifier for each component. This protocol enables the form builder
/// to track, manage, and render different types of components in a consistent manner.
///
/// ## Overview
///
/// All form elements, including fields, layout components, and UI elements, must conform
/// to this protocol. The `id` property ensures that each component can be uniquely
/// identified within the form structure, which is essential for:
/// - State management
/// - Validation tracking
/// - UI updates and rendering
/// - Accessibility support
///
/// ## Example
///
/// ```swift
/// struct CustomFormComponent: FormComponent {
///     let id: String = UUID().uuidString
///     
///     // Additional component-specific properties...
/// }
/// ```
///
/// - Note: The `id` should be unique within the form to ensure proper component tracking.
/// - Important: This protocol inherits from `Identifiable`, making components compatible
///   with SwiftUI's ForEach and other identifier-based APIs.
public protocol FormComponent: Identifiable {
    /// A unique identifier for the form component.
    ///
    /// This identifier is used throughout the form builder system to:
    /// - Track component state
    /// - Manage validation results
    /// - Handle user interactions
    /// - Support accessibility features
    ///
    /// The identifier should remain constant throughout the component's lifecycle
    /// and be unique within the form context.
    var id: String { get }
}
