//
//  FormDefinition.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

/// The main protocol for defining complete form structures in the FormBuilder library.
///
/// `FormDefinition` serves as the primary entry point for creating forms, providing
/// the essential metadata and structure that defines how a form should appear and behave.
/// Types conforming to this protocol represent complete, renderable form definitions.
///
/// ## Overview
///
/// A form definition encapsulates:
/// - Form metadata (title, submit button text)
/// - Complete form structure through the `body` property
/// - Implicit integration with the form builder's DSL (Domain Specific Language)
///
/// The `@FormComponentBuilder` attribute on the `body` property enables the use of
/// FormBuilder's declarative syntax, allowing for intuitive form construction using
/// a SwiftUI-like approach.
///
/// ## Usage Pattern
///
/// Forms are typically defined as structs conforming to `FormDefinition`:
///
/// ```swift
/// struct RegistrationForm: FormDefinition {
///     var title: String { "User Registration" }
///     var submitButtonTitle: String { "Create Account" }
///     
///     var body: some FormContent {
///         FormComponents {
///             Section("Personal Information") {
///                 TextField("email")
///                     .label("Email Address")
///                     .required()
///                     .email()
///                 
///                 TextField("password")
///                     .label("Password")
///                     .required()
///                     .minLength(8)
///             }
///         }
///     }
/// }
/// ```
///
/// ## Integration with FormView
///
/// Form definitions are rendered using `FormView`:
///
/// ```swift
/// FormView(definition: RegistrationForm())
///     .onSubmit { values in
///         // Handle form submission
///         print("Form submitted with values: \(values)")
///     }
/// ```
///
/// - Note: The `body` property uses the `@FormComponentBuilder` result builder to enable declarative syntax.
/// - Important: Form definitions should be lightweight and stateless, as state management is handled by the FormView.
public protocol FormDefinition {
    /// The title displayed in the form's navigation bar.
    ///
    /// This title appears at the top of the form and should clearly indicate
    /// the form's purpose to users. It's used for:
    /// - Navigation bar display
    /// - Accessibility announcement
    /// - User orientation
    ///
    /// ## Example
    /// ```swift
    /// var title: String { "Employee Registration" }
    /// ```
    var title: String { get }
    
    /// The text displayed on the form's submit button.
    ///
    /// This text should be action-oriented and clearly indicate what will
    /// happen when the user taps the button. Common examples include:
    /// - "Submit"
    /// - "Save"
    /// - "Create Account"
    /// - "Update Profile"
    ///
    /// ## Example
    /// ```swift
    /// var submitButtonTitle: String { "Create Account" }
    /// ```
    var submitButtonTitle: String { get }
    
    /// The complete structure and content of the form.
    ///
    /// This property defines the form's layout, fields, and components using
    /// FormBuilder's declarative syntax. The `@FormComponentBuilder` attribute
    /// enables the use of the form builder DSL for intuitive form construction.
    ///
    /// The body can contain any combination of:
    /// - Form fields (text, date, toggle, picker, etc.)
    /// - Layout components (sections, rows, columns)
    /// - UI elements (text, spacers, dividers)
    /// - Conditional components
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder 
    /// var body: some FormContent {
    ///     FormComponents {
    ///         TextField("email").required().email()
    ///         ToggleFormField("newsletter").label("Subscribe to newsletter")
    ///     }
    /// }
    /// ```
    @FormComponentBuilder var body: any FormContent { get }
}
