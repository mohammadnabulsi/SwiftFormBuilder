//
//  FormLayout.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI
import UIKit

/// Configuration struct that defines the visual layout and presentation of a form.
///
/// `FormLayout` provides a comprehensive set of options for customizing how forms
/// are displayed, including spacing, colors, navigation behavior, and UI controls.
/// This struct allows fine-grained control over the form's visual appearance while
/// maintaining consistency across different form instances.
///
/// ## Overview
///
/// The layout configuration affects:
/// - Content spacing and padding
/// - Background colors and visual styling
/// - Navigation bar appearance and behavior
/// - Submit button visibility and placement
///
/// ## Predefined Layouts
///
/// FormBuilder provides two predefined layout configurations:
/// - `.default` - Standard layout with comfortable spacing and large title
/// - `.compact` - Condensed layout with reduced padding and inline title
///
/// ## Custom Layout Example
///
/// ```swift
/// let customLayout = FormLayout(
///     contentPadding: EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16),
///     backgroundColor: Color(.systemGray6),
///     titleDisplayMode: .inline,
///     showSubmitButton: true
/// )
/// 
/// FormView(definition: myForm, layout: customLayout)
/// ```
///
/// ## Integration with FormView
///
/// Layout configurations are applied when creating a FormView:
///
/// ```swift
/// FormView(definition: registrationForm, layout: .compact)
/// ```
///
/// - Note: Layout changes affect the entire form's appearance and should be chosen to match your app's design system.
/// - Important: Some layout properties may be platform-specific and could behave differently on iOS vs other platforms.
public struct FormLayout : Sendable{
    /// The padding applied around the form's content area.
    ///
    /// This padding creates space between the form content and the edges of the
    /// container, improving visual appearance and readability. The padding is
    /// applied uniformly around all form components.
    ///
    /// ## Default Value
    /// `EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)`
    ///
    /// ## Example
    /// ```swift
    /// // Compact padding for dense layouts
    /// let tightPadding = EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
    /// 
    /// // Generous padding for spacious layouts
    /// let relaxedPadding = EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20)
    /// ```
    public var contentPadding: EdgeInsets
    
    /// The background color of the form container.
    ///
    /// This color is applied to the entire form background, creating the base
    /// visual context for all form components. It should provide appropriate
    /// contrast for form fields and text.
    ///
    /// ## Default Value
    /// `Color(.systemGroupedBackground)` - Adapts to light/dark mode
    ///
    /// ## Example
    /// ```swift
    /// // Pure white background
    /// backgroundColor = Color.white
    /// 
    /// // Custom branded background
    /// backgroundColor = Color("BrandBackground")
    /// ```
    public var backgroundColor: Color
    
    /// The display mode for the navigation bar title.
    ///
    /// Controls how the form's title appears in the navigation bar, affecting
    /// the visual hierarchy and available space for content.
    ///
    /// ## Options
    /// - `.large` - Large title that collapses on scroll (iOS 11+)
    /// - `.inline` - Standard inline title that remains fixed
    ///
    /// ## Default Value
    /// `.large`
    ///
    /// - Important: This property is marked for removal (TODO: Remove) and may be deprecated in future versions.
    public var titleDisplayMode: NavigationBarItem.TitleDisplayMode // TODO: Remove
    
    /// Controls whether the submit button is displayed in the form.
    ///
    /// When enabled, a submit button appears in the navigation bar's trailing
    /// position, allowing users to submit the form. When disabled, form submission
    /// must be handled through custom UI elements or programmatic triggers.
    ///
    /// ## Default Value
    /// `true`
    ///
    /// ## Usage
    /// ```swift
    /// // Hide submit button for multi-step forms
    /// let wizardLayout = FormLayout(showSubmitButton: false)
    /// 
    /// // Show submit button for single-page forms
    /// let standardLayout = FormLayout(showSubmitButton: true)
    /// ```
    public var showSubmitButton: Bool
    
    /// Creates a new form layout configuration with the specified parameters.
    ///
    /// All parameters have sensible defaults, so you only need to specify the
    /// properties you want to customize.
    ///
    /// - Parameters:
    ///   - contentPadding: The padding around form content (default: 16pt all sides)
    ///   - backgroundColor: The form background color (default: system grouped background)
    ///   - titleDisplayMode: Navigation title display style (default: .large)
    ///   - showSubmitButton: Whether to show the submit button (default: true)
    public init(
        contentPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        backgroundColor: Color = Color(.systemGroupedBackground),
        titleDisplayMode: NavigationBarItem.TitleDisplayMode = .large,
        showSubmitButton: Bool = true
    ) {
        self.contentPadding = contentPadding
        self.backgroundColor = backgroundColor
        self.titleDisplayMode = titleDisplayMode
        self.showSubmitButton = showSubmitButton
    }
    
    /// A standard form layout with comfortable spacing and large title.
    ///
    /// This layout provides a balanced appearance suitable for most forms,
    /// with generous padding and a prominent title that collapses on scroll.
    ///
    /// ## Characteristics
    /// - 16pt padding on all sides
    /// - System grouped background color
    /// - Large navigation title
    /// - Submit button enabled
    public static let `default` = FormLayout()
    
    /// A compact form layout optimized for space efficiency.
    ///
    /// This layout reduces padding and uses an inline title to maximize
    /// the available space for form content, ideal for dense forms or
    /// smaller screens.
    ///
    /// ## Characteristics
    /// - 8pt vertical, 12pt horizontal padding
    /// - System grouped background color
    /// - Inline navigation title
    /// - Submit button enabled
    public static let compact = FormLayout(
        contentPadding: EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12),
        titleDisplayMode: .inline
    )
}
