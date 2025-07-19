//
//  FormContent.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// A protocol representing a container that holds multiple form components.
///
/// `FormContent` extends `FormComponent` to represent composite elements that can
/// contain and organize multiple child components. This protocol is essential for
/// creating structured, hierarchical form layouts and enabling the form builder's
/// declarative syntax.
///
/// ## Overview
///
/// Form content serves as a container abstraction that allows grouping of related
/// form components. Types conforming to this protocol act as composite components
/// that can hold and organize multiple child elements, enabling:
/// - Hierarchical form structure
/// - Logical grouping of related fields
/// - Reusable form sections
/// - Complex layout arrangements
///
/// ## Common Implementations
///
/// The SwiftFormBuilder library provides several built-in form content types:
/// - `FormComponents` - Root container for form elements
/// - `FormSection` - Grouped content with optional title
/// - `FormRow` - Horizontal arrangement of components
/// - `FormColumn` - Vertical arrangement of components
/// - `FormCard` - Visually grouped content with styling
///
/// ## Usage in Form Builder DSL
///
/// Form content types are typically used within the `@FormComponentBuilder` syntax:
///
/// ```swift
/// var body: some FormContent {
///     FormComponents {
///         Section("Personal Info") {
///             TextField("firstName").label("First Name")
///             TextField("lastName").label("Last Name")
///         }
///         
///         Row {
///             TextField("city").label("City")
///             TextField("zipCode").label("ZIP Code")
///         }
///     }
/// }
/// ```
///
/// ## Custom Form Content
///
/// You can create custom form content containers:
///
/// ```swift
/// struct AddressSection: FormContent {
///     let id = UUID().uuidString
///     let components: [any FormComponent]
///     
///     init(@FormComponentBuilder builder: () -> [any FormComponent]) {
///         self.components = builder()
///     }
/// }
/// ```
///
/// - Note: Form content types automatically participate in the form's rendering and layout system.
/// - Important: The `components` array should contain the child elements that will be rendered within this container.
public protocol FormContent: FormComponent {
    /// The array of child components contained within this form content.
    ///
    /// This property holds all the child components that belong to this container.
    /// The components are rendered in the order they appear in the array, and each
    /// maintains its own identity and state within the form system.
    ///
    /// The components array can contain any mix of:
    /// - Form fields (input elements)
    /// - Other form content containers (nested structure)
    /// - UI components (text, spacers, dividers)
    /// - Layout components (rows, columns)
    ///
    /// ## Example
    /// ```swift
    /// let components: [any FormComponent] = [
    ///     TextField("email").required(),
    ///     TextField("password").required().minLength(8),
    ///     ToggleFormField("rememberMe").label("Remember me")
    /// ]
    /// ```
    ///
    /// - Note: The array uses existential types (`any FormComponent`) to allow heterogeneous component storage.
    var components: [any FormComponent] { get }
}
