//
//  EnhancedFormComponentBuilder.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation
import SwiftUICore

/// A result builder that enables declarative syntax for constructing form components.
///
/// `FormComponentBuilder` is the core of FormBuilder's Domain Specific Language (DSL),
/// providing a SwiftUI-like syntax for building forms declaratively. This result builder
/// transforms block-based component declarations into arrays of form components that can
/// be processed by the form rendering system.
///
/// ## Overview
///
/// The result builder enables intuitive form construction using Swift's result builder syntax:
/// - Natural, readable form definitions
/// - Compile-time validation of form structure
/// - Support for conditional and dynamic content
/// - Integration with Swift's control flow constructs
///
/// ## Supported Constructs
///
/// The builder supports various Swift language constructs:
/// - Sequential component listing
/// - Conditional components (`if`, `else`)
/// - Optional components
/// - Arrays of components
/// - Mixed component types
///
/// ## Example Usage
///
/// ```swift
/// @FormComponentBuilder
/// var formContent: [any FormComponent] {
///     TextField("email").required()
///     
///     if showAdvanced {
///         Section("Advanced Options") {
///             ToggleField("newsletter")
///             DatePicker("birthdate")
///         }
///     }
///     
///     Row {
///         TextField("firstName")
///         TextField("lastName")
///     }
/// }
/// ```
///
/// ## Integration with Form Definitions
///
/// The builder is automatically applied to the `body` property of `FormDefinition`:
///
/// ```swift
/// struct MyForm: FormDefinition {
///     var title: String { "My Form" }
///     var submitButtonTitle: String { "Submit" }
///     
///     @FormComponentBuilder
///     var body: some FormContent {
///         FormComponents {
///             TextField("email").required()
///             TextField("password").required().minLength(8)
///         }
///     }
/// }
/// ```
///
/// - Note: This result builder follows the same patterns as SwiftUI's ViewBuilder for consistency.
/// - Important: All components within the builder must conform to the `FormComponent` protocol.
@resultBuilder
public struct FormComponentBuilder {
    /// Builds a component array from a sequence of individual components.
    ///
    /// This method handles the basic case of listing multiple components sequentially
    /// within a builder block. Each component is collected into an array that can be
    /// processed by the form system.
    ///
    /// - Parameter components: Variable number of form components
    /// - Returns: Array containing all provided components
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder
    /// var content: [any FormComponent] {
    ///     TextField("email")     // buildBlock collects these
    ///     TextField("password")  // into an array
    ///     ToggleField("remember")
    /// }
    /// ```
    public static func buildBlock(_ components: any FormComponent...) -> [any FormComponent] {
        return components
    }
    
    /// Builds a component from the first branch of a conditional statement.
    ///
    /// This method handles the `if` branch of conditional component inclusion,
    /// allowing forms to dynamically include or exclude components based on
    /// runtime conditions.
    ///
    /// - Parameter component: The component from the `if` branch
    /// - Returns: The component to include when the condition is true
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder
    /// var content: [any FormComponent] {
    ///     if userIsAdmin {
    ///         TextField("adminCode")  // buildEither(first:) handles this
    ///     } else {
    ///         TextField("userCode")   // buildEither(second:) handles this
    ///     }
    /// }
    /// ```
    public static func buildEither(first component: any FormComponent) -> any FormComponent {
        return component
    }
    
    /// Builds a component from the second branch of a conditional statement.
    ///
    /// This method handles the `else` branch of conditional component inclusion,
    /// providing the alternative component when the primary condition is false.
    ///
    /// - Parameter component: The component from the `else` branch
    /// - Returns: The component to include when the condition is false
    public static func buildEither(second component: any FormComponent) -> any FormComponent {
        return component
    }
    
    /// Builds components from an array of components.
    ///
    /// This method handles cases where an array of components is provided within
    /// the builder, such as when using `ForEach` or when programmatically
    /// generating multiple components.
    ///
    /// - Parameter components: Array of form components
    /// - Returns: The same array of components
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder
    /// var content: [any FormComponent] {
    ///     let dynamicFields = createDynamicFields()
    ///     dynamicFields  // buildArray handles this
    /// }
    /// ```
    public static func buildArray(_ components: [any FormComponent]) -> [any FormComponent] {
        return components
    }
    
    /// Builds an optional component that may or may not be included.
    ///
    /// This method handles optional components that are conditionally included
    /// based on optional values or nullable conditions.
    ///
    /// - Parameter component: Optional form component
    /// - Returns: The component if present, nil otherwise
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder
    /// var content: [any FormComponent] {
    ///     TextField("email")
    ///     
    ///     if let user = currentUser {
    ///         TextField("welcome") // buildOptional handles this
    ///     }
    /// }
    /// ```
    public static func buildOptional(_ component: (any FormComponent)?) -> (any FormComponent)? {
        return component
    }
    
    /// Builds a component from a simple conditional statement without an else clause.
    ///
    /// This method handles `if` statements without corresponding `else` clauses,
    /// where a component may or may not be included based on a condition.
    ///
    /// - Parameter component: Optional form component from the `if` statement
    /// - Returns: The component if the condition was true, nil otherwise
    ///
    /// ## Example
    /// ```swift
    /// @FormComponentBuilder
    /// var content: [any FormComponent] {
    ///     TextField("email")
    ///     
    ///     if showOptionalField {
    ///         TextField("optional")  // buildIf handles this
    ///     }
    /// }
    /// ```
    public static func buildIf(_ component: (any FormComponent)?) -> (any FormComponent)? {
        return component
    }
    
    /// Builds components from an array expression.
    ///
    /// This method handles array literals or expressions that evaluate to arrays
    /// of components within the builder context.
    ///
    /// - Parameter expression: Array of form components
    /// - Returns: The array of components
    public static func buildExpression(_ expression: [any FormComponent]) -> [any FormComponent] {
        return expression
    }
    
    /// Builds a single component from an expression.
    ///
    /// This method handles individual component expressions within the builder,
    /// ensuring they are properly typed and included in the result.
    ///
    /// - Parameter expression: A single form component
    /// - Returns: The form component
    public static func buildExpression(_ expression: any FormComponent) -> any FormComponent {
        return expression
    }
}

// MARK: - Convenience Factory Functions

/// Creates a text input field with the specified identifier.
///
/// This function provides a convenient way to create text form fields using the
/// FormBuilder DSL. The returned field can be further configured using method chaining.
///
/// - Parameter id: Unique identifier for the text field
/// - Returns: A configurable `TextFormField` instance
///
/// ## Example
/// ```swift
/// TextField("email")
///     .label("Email Address")
///     .placeholder("Enter your email")
///     .required()
///     .email()
/// ```
public func TextField(_ id: String) -> TextFormField {
    return TextFormField(id: id)
}

/// Creates a date picker field with the specified identifier.
///
/// This function provides a convenient way to create date input fields using the
/// FormBuilder DSL. The returned field can be configured for various date and time
/// input scenarios.
///
/// - Parameter id: Unique identifier for the date field
/// - Returns: A configurable `DateFormField` instance
///
/// ## Example
/// ```swift
/// DatePicker("birthdate")
///     .label("Date of Birth")
///     .required()
///     .maxDate(Date())
/// ```
public func DatePicker(_ id: String) -> DateFormField {
    return DateFormField(id: id)
}

/// Creates a toggle/switch field with the specified identifier.
///
/// This function provides a convenient way to create boolean toggle fields using
/// the FormBuilder DSL. Perfect for yes/no questions, feature toggles, and settings.
///
/// - Parameter id: Unique identifier for the toggle field
/// - Returns: A configurable `ToggleFormField` instance
///
/// ## Example
/// ```swift
/// ToggleField("newsletter")
///     .label("Subscribe to newsletter")
///     .required()
/// ```
public func ToggleField(_ id: String) -> ToggleFormField {
    return ToggleFormField(id: id)
}

/// Creates a picker field for selecting from multiple options.
///
/// This function provides a convenient way to create selection fields using the
/// FormBuilder DSL. Supports both single and multi-selection scenarios.
///
/// - Parameter id: Unique identifier for the picker field
/// - Returns: A configurable `PickerFormField` instance
///
/// ## Example
/// ```swift
/// PickerField("country")
///     .label("Country")
///     .options(countries)
///     .required()
/// ```
public func PickerField(_ id: String) -> PickerFormField {
    return PickerFormField(id: id)
}

/// Creates a form section with an optional title and contained components.
///
/// Sections provide logical grouping of related form fields with optional visual
/// separation and title display.
///
/// - Parameters:
///   - title: Optional section title
///   - components: Builder closure containing section components
/// - Returns: A `FormSection` containing the specified components
///
/// ## Example
/// ```swift
/// Section("Personal Information") {
///     TextField("firstName").required()
///     TextField("lastName").required()
///     DatePicker("birthdate")
/// }
/// ```
public func Section(_ title: String, @FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(title, components: components)
}

/// Creates a form section without a title.
///
/// This overload creates an untitled section for grouping components without
/// displaying a section header.
///
/// - Parameter components: Builder closure containing section components
/// - Returns: A `FormSection` without a title
public func Section(@FormComponentBuilder components: () -> [any FormComponent]) -> FormSection {
    return FormSection(nil, components: components)
}

/// Creates a horizontal row layout containing multiple components.
///
/// Rows arrange components horizontally with configurable spacing and alignment,
/// perfect for placing related fields side by side.
///
/// - Parameters:
///   - spacing: Horizontal spacing between components (default: 16)
///   - alignment: Vertical alignment of components (default: .top)
///   - components: Builder closure containing row components
/// - Returns: A `FormRow` with the specified layout
///
/// ## Example
/// ```swift
/// Row(spacing: 12, alignment: .center) {
///     TextField("firstName").label("First Name")
///     TextField("lastName").label("Last Name")
/// }
/// ```
public func Row(spacing: CGFloat = 16, alignment: VerticalAlignment = .top, @FormComponentBuilder components: () -> [any FormComponent]) -> FormRow {
    return FormRow(spacing: spacing, alignment: alignment, components: components)
}

/// Creates a vertical column layout containing multiple components.
///
/// Columns arrange components vertically with configurable spacing and alignment,
/// useful for creating structured vertical layouts within forms.
///
/// - Parameters:
///   - spacing: Vertical spacing between components (default: 16)
///   - alignment: Horizontal alignment of components (default: .leading)
///   - components: Builder closure containing column components
/// - Returns: A `FormColumn` with the specified layout
///
/// ## Example
/// ```swift
/// Column(spacing: 8, alignment: .leading) {
///     TextField("address").label("Street Address")
///     TextField("city").label("City")
///     TextField("zipCode").label("ZIP Code")
/// }
/// ```
public func Column(spacing: CGFloat = 16, alignment: HorizontalAlignment = .leading, @FormComponentBuilder components: () -> [any FormComponent]) -> FormColumn {
    return FormColumn(spacing: spacing, alignment: alignment, components: components)
}

/// Creates a spacer component with the specified size.
///
/// Spacers provide controlled vertical spacing between form components,
/// helping to create visual breathing room and improve form layout.
///
/// - Parameter size: The size of the spacer in points
/// - Returns: A `FormSpacer` with the specified size
///
/// ## Example
/// ```swift
/// TextField("email")
/// Spacer(24)  // Add 24 points of vertical space
/// TextField("password")
/// ```
public func Spacer(_ size: CGFloat) -> FormSpacer {
    return FormSpacer(size)
}

/// Creates a visual divider line between form components.
///
/// Dividers provide visual separation between sections or groups of components,
/// helping to organize form content visually.
///
/// - Parameters:
///   - color: The color of the divider line (default: .secondary)
///   - thickness: The thickness of the divider line (default: 1)
/// - Returns: A `FormDivider` with the specified appearance
///
/// ## Example
/// ```swift
/// Section("Basic Info") {
///     TextField("name")
/// }
/// 
/// Divider(color: .gray, thickness: 2)
/// 
/// Section("Contact Info") {
///     TextField("email")
/// }
/// ```
public func Divider(color: Color = .secondary, thickness: CGFloat = 1) -> FormDivider {
    return FormDivider(color: color, thickness: thickness)
}

/// Creates a text display component for labels, instructions, or information.
///
/// Text components provide non-interactive text content within forms, useful for
/// instructions, labels, descriptions, or informational content.
///
/// - Parameters:
///   - text: The text content to display
///   - font: The font style for the text (default: .body)
///   - color: The text color (default: .primary)
/// - Returns: A `FormText` component with the specified styling
///
/// ## Example
/// ```swift
/// Text("Please fill out all required fields", font: .caption, color: .secondary)
/// ```
public func Text(_ text: String, font: Font = .body, color: Color = .primary) -> FormText {
    return FormText(text, font: font, color: color)
}

/// Creates a card container for grouping related components with visual styling.
///
/// Cards provide an elevated, visually distinct container for grouping related
/// form components, often used for sections that need extra visual prominence.
///
/// - Parameters:
///   - title: Optional card title
///   - subtitle: Optional card subtitle
///   - style: Visual styling configuration for the card
///   - components: Builder closure containing card components
/// - Returns: A `FormCard` with the specified content and styling
///
/// ## Example
/// ```swift
/// Card(title: "Payment Information", subtitle: "Secure checkout") {
///     TextField("cardNumber").label("Card Number")
///     Row {
///         TextField("expiry").label("MM/YY")
///         TextField("cvv").label("CVV")
///     }
/// }
/// ```
public func Card(
    title: String? = nil,
    subtitle: String? = nil,
    style: FormCard.CardStyle = FormCard.CardStyle(),
    @FormComponentBuilder components: () -> [any FormComponent]
) -> FormCard {
    return FormCard(title: title, subtitle: subtitle, style: style, components: components)
}

/// Creates a conditional component that renders based on form state.
///
/// Conditional components allow dynamic form behavior where components are shown
/// or hidden based on the values of other form fields, enabling complex form logic.
///
/// - Parameters:
///   - condition: Closure that evaluates form values and returns visibility
///   - components: Builder closure containing conditional components
/// - Returns: A `ConditionalFormComponent` with the specified logic
///
/// ## Example
/// ```swift
/// ConditionalComponent(
///     condition: { values in
///         values["userType"]?.stringValue == "admin"
///     }
/// ) {
///     TextField("adminCode").label("Admin Code").required()
/// }
/// ```
public func ConditionalComponent(
    condition: @escaping ([String: FieldValue]) -> Bool,
    @FormComponentBuilder components: () -> [any FormComponent]
) -> ConditionalFormComponent {
    return ConditionalFormComponent(condition: condition, components: components)
}

/// Creates a dynamic list of components based on a collection of items.
///
/// Lists enable dynamic form generation where the number and content of components
/// depend on runtime data, perfect for variable-length forms or repeated sections.
///
/// - Parameters:
///   - items: Array of identifiable items to generate components for
///   - itemBuilder: Closure that creates a component for each item
/// - Returns: A `FormList` that generates components dynamically
///
/// ## Example
/// ```swift
/// List(items: employees) { employee in
///     TextField("salary_\(employee.id)")
///         .label("\(employee.name)'s Salary")
///         .required()
/// }
/// ```
public func List<Item: Identifiable>(
    items: [Item],
    @FormComponentBuilder itemBuilder: @escaping (Item) -> any FormComponent
) -> FormList<Item> {
    return FormList(items: items, itemBuilder: itemBuilder)
}
