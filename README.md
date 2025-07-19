# SwiftFormBuilder

A powerful, declarative form building library for SwiftUI that provides a clean DSL for creating complex forms with validation, state management, and flexible layouts.

## Features

- 🎯 **Declarative DSL** - SwiftUI-like syntax for building forms
- 🔧 **Type-Safe** - Strongly typed field values and validation results  
- ✅ **Comprehensive Validation** - Built-in validation rules with custom rule support
- 🎨 **Flexible Layouts** - Rows, columns, sections, and cards for organizing content
- 📱 **State Management** - Centralized form state with reactive updates
- 🎮 **Field Types** - Text, date, toggle, picker, stepper, and more
- 🔄 **Conditional Logic** - Dynamic form content based on field values
- 🎭 **Theming** - Customizable styling and layout options
- 📋 **Form Submission** - Built-in submission handling with validation

## Quick Start

### Installation

Add SwiftFormBuilder to your Swift Package Manager dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/SwiftFormBuilder/SwiftFormBuilder.git", from: "1.0.0")
]
```

### Basic Usage

```swift
import SwiftUI
import SwiftFormBuilder

struct RegistrationForm: FormDefinition {
    var title: String { "Create Account" }
    var submitButtonTitle: String { "Register" }
    
    var body: some FormContent {
        FormComponents {
            Section("Personal Information") {
                TextField("firstName")
                    .label("First Name")
                    .required()
                
                TextField("lastName")
                    .label("Last Name")
                    .required()
                
                TextField("email")
                    .label("Email Address")
                    .required()
                    .email()
            }
            
            Section("Preferences") {
                ToggleField("newsletter")
                    .label("Subscribe to newsletter")
                
                PickerField("country")
                    .label("Country")
                    .options(["US", "Canada", "UK"])
                    .required()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        FormView(definition: RegistrationForm())
            .onSubmit { values in
                print("Form submitted: \(values)")
            }
    }
}
```

## Architecture

SwiftFormBuilder is built around several key concepts:

### Form Components

All form elements conform to the `FormComponent` protocol, providing a unique identifier and enabling type-safe composition.

### Field Types

- **TextField** - Single and multi-line text input
- **DatePicker** - Date and time selection
- **ToggleField** - Boolean switches
- **PickerField** - Single and multi-selection
- **StepperField** - Numeric input with steppers

### Layout Components

- **Section** - Groups related fields with optional titles
- **Row** - Horizontal arrangement of components
- **Column** - Vertical arrangement of components
- **Card** - Visually elevated grouping with styling
- **Spacer** - Controlled spacing between elements
- **Divider** - Visual separation lines

### State Management

SwiftFormBuilder uses a centralized state management system:

- **FormStateManager** - Manages all field values and validation results
- **FieldState** - Observable state for individual fields
- **FieldValue** - Type-safe value enumeration

### Validation System

Built-in validation rules with extensibility:

- **RequiredValidationRule** - Ensures fields are not empty
- **EmailValidationRule** - Validates email format
- **MinLengthValidationRule** - Minimum character count
- **Custom Rules** - Implement `ValidationRule` protocol

## Advanced Usage

### Complex Layouts

```swift
var body: some FormContent {
    FormComponents {
        Text("Employee Registration", font: .title)
        
        Spacer(20)
        
        Card(title: "Basic Information") {
            Row {
                TextField("firstName").label("First Name").required()
                TextField("lastName").label("Last Name").required()
            }
            
            TextField("email").label("Email").required().email()
            
            Column {
                TextField("address").label("Street Address")
                Row {
                    TextField("city").label("City")
                    TextField("zipCode").label("ZIP Code")
                }
            }
        }
        
        Divider()
        
        Section("Employment Details") {
            PickerField("department")
                .label("Department")
                .options(departments.map { $0.name })
                .required()
            
            DatePicker("startDate")
                .label("Start Date")
                .required()
        }
    }
}
```

### Conditional Fields

```swift
var body: some FormContent {
    FormComponents {
        PickerField("userType")
            .label("User Type")
            .options(["Regular", "Admin"])
            .required()
        
        ConditionalComponent(
            condition: { values in
                values["userType"]?.stringValue == "Admin"
            }
        ) {
            TextField("adminCode")
                .label("Admin Access Code")
                .required()
                .minLength(8)
        }
    }
}
```

### Custom Validation

```swift
struct CustomPasswordRule: ValidationRule {
    func validate(_ value: FieldValue) -> ValidationResult {
        guard case .text(let password) = value else {
            return .invalid("Password is required")
        }
        
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasNumber = password.range(of: "[0-9]", options: .regularExpression) != nil
        
        if hasUppercase && hasNumber {
            return .valid
        } else {
            return .invalid("Password must contain uppercase letter and number")
        }
    }
}

// Usage
TextField("password")
    .label("Password")
    .required()
    .validationRules([CustomPasswordRule()])
```

### Form Submission

```swift
FormView(definition: myForm)
    .onSubmit { values in
        // Handle successful submission
        submitToAPI(values)
    }
    .onValueChanged { values in
        // Handle real-time value changes
        autoSave(values)
    }
    .onValidationChanged { isValid in
        // Handle validation state changes
        updateSubmitButton(enabled: isValid)
    }
```

### Custom Layouts

```swift
let customLayout = FormLayout(
    contentPadding: EdgeInsets(top: 20, leading: 16, bottom: 20, trailing: 16),
    backgroundColor: .systemGray6,
    titleDisplayMode: .inline,
    showSubmitButton: true
)

FormView(definition: myForm, layout: customLayout)
```

### Dynamic Forms

```swift
struct DynamicForm: FormDefinition {
    let employees: [Employee]
    
    var body: some FormContent {
        FormComponents {
            Text("Salary Review", font: .title)
            
            List(items: employees) { employee in
                TextField("salary_\(employee.id)")
                    .label("\(employee.name)'s Salary")
                    .required()
            }
        }
    }
}
```

## Field Configuration

### Text Fields

```swift
TextField("email")
    .label("Email Address")
    .placeholder("user@example.com")
    .required()
    .email()
    .minLength(5)
```

### Date Pickers

```swift
DatePicker("birthdate")
    .label("Date of Birth")
    .required()
    .maxDate(Date())
    .minDate(Calendar.current.date(byAdding: .year, value: -100, to: Date()))
```

### Toggle Fields

```swift
ToggleField("notifications")
    .label("Enable Notifications")
    .defaultValue(true)
```

### Picker Fields

```swift
PickerField("country")
    .label("Country")
    .options(countries)
    .multiple() // For multi-selection
    .required()
```

## Validation Rules

### Built-in Rules

- `required()` - Field must have a value
- `email()` - Valid email format
- `minLength(Int)` - Minimum character count
- `maxLength(Int)` - Maximum character count
- `pattern(String)` - Regular expression matching

### Custom Validation

```swift
struct URLValidationRule: ValidationRule {
    func validate(_ value: FieldValue) -> ValidationResult {
        guard case .text(let urlString) = value,
              URL(string: urlString) != nil else {
            return .invalid("Please enter a valid URL")
        }
        return .valid
    }
}
```

## Styling and Theming

### Form Layouts

```swift
// Default layout
FormView(definition: myForm, layout: .default)

// Compact layout
FormView(definition: myForm, layout: .compact)

// Custom layout
let customLayout = FormLayout(
    contentPadding: EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20),
    backgroundColor: Color(.systemBackground),
    titleDisplayMode: .large,
    showSubmitButton: true
)
FormView(definition: myForm, layout: customLayout)
```

### Field Styling

```swift
TextField("name")
    .fieldStyle(.outlined)
    .accentColor(.blue)
```

### Card Styling

```swift
Card(
    title: "Payment Info",
    style: FormCard.CardStyle(
        backgroundColor: .white,
        cornerRadius: 12,
        shadowRadius: 4
    )
) {
    // Card content
}
```

## Best Practices

### Form Organization

1. **Group related fields** using sections and cards
2. **Use descriptive labels** and placeholders
3. **Apply consistent spacing** with spacers and dividers
4. **Implement proper validation** for user feedback

### Performance

1. **Use lazy loading** for large dynamic forms
2. **Minimize state updates** by using appropriate validation timing
3. **Optimize re-renders** by breaking large forms into smaller components

### User Experience

1. **Provide immediate feedback** with real-time validation
2. **Use conditional logic** to show relevant fields only
3. **Implement proper error handling** with clear messages
4. **Support accessibility** with proper labels and hints

## API Reference

### Core Protocols

- `FormDefinition` - Main protocol for defining forms
- `FormComponent` - Base protocol for all form elements
- `FormField` - Protocol for interactive input fields
- `FormContent` - Protocol for component containers

### State Management

- `FormStateManager` - Centralized state management
- `FieldState` - Observable state for individual fields
- `FieldValue` - Type-safe value enumeration

### Validation

- `ValidationRule` - Protocol for validation logic
- `ValidationResult` - Validation outcome representation
- `ValidationError` - Error information container

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details on:

- Code style and conventions
- Submitting bug reports
- Proposing new features
- Creating pull requests

## License

SwiftFormBuilder is available under the MIT License. See [LICENSE](LICENSE) for details.

---

Built with ❤️ for the SwiftUI community.
