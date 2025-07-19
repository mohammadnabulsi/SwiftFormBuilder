//
//  ComprehensiveForm.swift
//  SwiftFormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftFormBuilder
import Foundation

struct Country: Identifiable {
    let id = UUID()
    let name: String
    let code: String
}

struct Department: Identifiable {
    let id = UUID()
    let name: String
}

struct ComprehensiveForm: FormDefinition {
    var title: String = "Employee Registration"
    var submitButtonTitle: String = "Submit Application"
    
    // Sample data
    let countries = [
        Country(name: "United States", code: "US"),
        Country(name: "Canada", code: "CA"),
        Country(name: "United Kingdom", code: "UK"),
        Country(name: "Germany", code: "DE"),
        Country(name: "Austria", code: "AT")
    ]
    
    let departments = [
        Department(name: "Engineering"),
        Department(name: "Design"),
        Department(name: "Marketing"),
        Department(name: "Sales"),
        Department(name: "HR")
    ]
    
    var body: any FormContent {
        return FormComponents {
            Text("Welcome to our company! Please fill out this comprehensive form.")
            
            Spacer(16)
            
            // Personal Information Section
            Section("Personal Information") {
                // Basic personal fields in a row
                Row(spacing: 12) {
                    TextField("firstName")
                        .label("First Name")
                        .placeholder("Enter your first name")
                        .required()
                        .minLength(2)
                    
                    TextField("lastName")
                        .label("Last Name")
                        .placeholder("Enter your last name")
                        .required()
                        .minLength(2)
                }
                
                // Email and phone
                TextField("email")
                    .label("Email Address")
                    .placeholder("you@example.com")
                    .email()
                    .required()
                
                TextField("phone")
                    .label("Phone Number")
                    .placeholder("+1 (555) 123-4567")
                    .required()
                
                // Date of birth
                DatePicker("dateOfBirth")
                    .label("Date of Birth")
                    .required()
                    .maxDate(Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())
                
                // Address in a column
                Column(spacing: 8) {
                    TextField("address")
                        .label("Street Address")
                        .placeholder("123 Main Street")
                        .required()
                    
                    Row {
                        TextField("city")
                            .label("City")
                            .placeholder("New York")
                            .required()
                        
                        TextField("zipCode")
                            .label("ZIP Code")
                            .placeholder("10001")
                            .required()
                            .minLength(5)
                    }
                    
                    PickerField("country")
                        .label("Country")
                        .options(countries.map { $0.name })
                        .required()
                }
            }
            
            Divider()
            
            // Employment Information Card
            Card(title: "Employment Information", subtitle: "Tell us about your professional background") {
                PickerField("department")
                    .label("Preferred Department")
                    .options(departments.map { $0.name })
                    .required()
                
                TextField("jobTitle")
                    .label("Desired Job Title")
                    .placeholder("Software Engineer")
                    .required()
                
                Row {
                    TextField("experience")
                        .label("Years of Experience")
                        .placeholder("5")
                        .required()
                    
                    TextField("expectedSalary")
                        .label("Expected Salary")
                        .placeholder("$75,000")
                }
                
                DatePicker("availableStartDate")
                    .label("Available Start Date")
                    .required()
                
                // Skills section with toggles
                Text("Skills & Certifications")
                
                Column(spacing: 4) {
                    ToggleField("hasDriversLicense")
                        .label("Driver's License")
                        .defaultValue(false)
                    
                    ToggleField("willingToRelocate")
                        .label("Willing to Relocate")
                        .defaultValue(false)
                    
                    ToggleField("hasSecurityClearance")
                        .label("Security Clearance")
                        .defaultValue(false)
                }
            }
            
            Spacer(20)
            
            
            ToggleField("agreeToTerms")
                .label("I agree to the Terms and Conditions")
                .required()
            
            // Conditional section - only shows if willing to relocate
            ConditionalComponent(condition: { values in
                values["agreeToTerms"]?.boolValue ?? false
            }) {
                Section("Relocation Preferences") {
                    Text("Since you're willing to relocate, please provide additional information:")
                    
                    PickerField("preferredLocation")
                        .label("Preferred Location")
                        .options(["New York", "San Francisco", "Austin", "Seattle", "Remote"])
                    
                    ToggleField("needsRelocationAssistance")
                        .label("Needs Relocation Assistance")
                        .defaultValue(true)
                }
            }
            
            Divider(color: .blue, thickness: 2)
            
            // Emergency Contact Information
            Section("Emergency Contact") {
                TextField("emergencyContactName")
                    .label("Contact Name")
                    .placeholder("Jane Doe")
                    .required()
                
                Row {
                    TextField("emergencyContactPhone")
                        .label("Phone Number")
                        .placeholder("+1 (555) 987-6543")
                        .required()
                    
                    PickerField("emergencyContactRelation")
                        .label("Relationship")
                        .options(["Spouse", "Parent", "Sibling", "Friend", "Other"])
                        .required()
                }
            }
            
            
            Spacer(20)
            
            // Additional Information
            Section {
                TextField("additionalInfo")
                    .label("Additional Information")
                    .placeholder("Tell us anything else we should know...")
                
                Column(spacing: 12, alignment: .leading) {
                    Text("Agreement & Consent")
                    
                    ToggleField("agreeToTerms")
                        .label("I agree to the Terms and Conditions")
                        .required()
                    
                    ToggleField("agreeToPrivacy")
                        .label("I agree to the Privacy Policy")
                        .required()
                    
                    ToggleField("allowMarketing")
                        .label("I agree to receive marketing communications")
                        .defaultValue(false)
                }
            }
            
            Spacer(32)
            
            // Custom styled components
            Text("By submitting this form, you acknowledge that all information provided is accurate.")
        }
    }
}
