import SwiftUI
import Foundation

struct FormData {
    private let values: [String: FieldValue]
    
    init(_ values: [String: FieldValue]) {
        self.values = values
    }
    
    func getString(_ key: String) -> String? {
        guard case .text(let value) = values[key] else { return nil }
        return value
    }
    
    func getBool(_ key: String) -> Bool? {
        guard case .boolean(let value) = values[key] else { return nil }
        return value
    }
    
    func getDate(_ key: String) -> Date? {
        guard case .date(let value) = values[key] else { return nil }
        return value
    }
    
    func getSelection(_ key: String) -> String? {
        guard case .selection(let value) = values[key] else { return nil }
        return value
    }
    
    func getNumber(_ key: String) -> Double? {
        guard case .number(let value) = values[key] else { return nil }
        return value
    }
    
    // Convert to a struct for easier handling
    func toUserRegistration() -> UserRegistration? {
        guard let firstName = getString("firstName"),
              let lastName = getString("lastName"),
              let email = getString("email"),
              let birthDate = getDate("birthDate"),
              let country = getSelection("country") else {
            return nil
        }
        
        return UserRegistration(
            firstName: firstName,
            lastName: lastName,
            email: email,
            birthDate: birthDate,
            notifications: getBool("notifications") ?? false,
            country: country
        )
    }
}

struct UserRegistration {
    let firstName: String
    let lastName: String
    let email: String
    let birthDate: Date
    let notifications: Bool
    let country: String
}

//struct UserRegistrationForm: FormDefinition {
//    var title: String { "User Registration" }
//    var submitButtonTitle: String { "Create Account" }
//    
//    var body: some FormComponent {
//        Section("Personal Information") {
//            TextField("firstName")
//                .label("First Name")
//                .required()
//                .minLength(2)
//            
//            TextField("lastName")
//                .label("Last Name")
//                .required()
//                .minLength(2)
//            
//            TextField("email")
//                .label("Email Address")
//                .required()
//                .email()
//            
//            DatePicker("birthDate")
//                .label("Date of Birth")
//                .required()
//                .maxDate(Date())
//        }
//        
//        Section("Account Settings") {
//            ToggleField("notifications")
//                .label("Enable Notifications")
//                .defaultValue(true)
//            
//            PickerField("country")
//                .label("Country")
//                .options(["United States", "Canada", "United Kingdom", "Germany", "France"])
//                .required()
//        }
//    }
//}

// MARK: - App Entry Point
struct ExampleForm: FormDefinition {
    var title: String { "Enhanced Form" }
    var submitButtonTitle: String { "Submit" }
    
    var body: FormComponents {
        return FormComponents {
            // Single field
            TextField("email2")
                .label("Email Address")
                .required()
                .email()
            // Row with two fields
            Row {
                TextField("firstName2")
                    .label("First Name")
                    .required()
                
                TextField("lastName2")
                    .label("Last Name")
                    .required()
            }
            
            
            FormSection("Personal Information") {
                // Row with two fields
                Row {
                    TextField("firstName")
                        .label("First Name")
                        .required()
                    
                    TextField("lastName")
                        .label("Last Name")
                        .required()
                }
                
                // Custom spacer
                Spacer(24)
                
                // Single field
                TextField("email")
                    .label("Email Address")
                    .required()
                    .email()
                
                // Divider
                Divider()
                
                // Text description
                Text("Please provide your birth date for age verification.",
                     font: .caption,
                     color: .secondary)
                
                // Date field
                DatePicker("birthDate")
                    .label("Date of Birth")
                    .required()
            }
            
            Section("Preferences") {
                // Column layout
                Column(spacing: 20) {
                    ToggleField("notifications")
                        .label("Enable Notifications")
                        .defaultValue(true)
                    
                    // Nested row inside column
                    Row {
                        PickerField("country")
                            .label("Country")
                            .options(["US", "CA", "UK"])
                            .required()
                        
                        PickerField("language")
                            .label("Language")
                            .options(["English", "Spanish", "French"])
                    }
                    
                    Spacer(16)
                    
                    Text("Your preferences help us customize your experience.",
                         font: .footnote,
                         color: .blue)
                }
            }
        }
    }
}


struct ContentView: View {
    @State private var formValues: [String: FieldValue] = [:]
    @State private var submittedData: UserRegistration?
    
    var body: some View {
        VStack {
            FormView(definition: ExampleForm())
                .onSubmit { values in
                    print("Form submitted!")
                    let formData = FormData(values)
                    
                    // Extract typed data
                    submittedData = formData.toUserRegistration()
                    
                    // Or access individual values
                    if let firstName = formData.getString("firstName") {
                        print("First Name: \(firstName)")
                    }
                    
                    if let email = formData.getString("email") {
                        print("Email: \(email)")
                    }
                    
                    if let notifications = formData.getBool("notifications") {
                        print("Notifications enabled: \(notifications)")
                    }
                }
                .onValueChanged { values in
                    // Real-time value monitoring
                    formValues = values
                    print("Form values changed: \(values)")
                }
            
            // Display submitted data
            if let userData = submittedData {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Submitted Data:")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("Name: \(userData.firstName) \(userData.lastName)")
                    Text("Email: \(userData.email)")
                    Text("Country: \(userData.country)")
                    Text("Notifications: \(userData.notifications ? "Yes" : "No")")
                    Text("Birth Date: \(DateFormatter.localizedString(from: userData.birthDate, dateStyle: .medium, timeStyle: .none))")
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
