//
//  RegistrationForm.swift
//  SwiftFormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import FormBuilder
import SwiftUI

struct RegistrationForm: FormDefinition {
    var title: String { "Create Account" }
    var submitButtonTitle: String { "Register" }
    
    var body: any FormContent {
        return FormComponents {
            // Personal Information Section
            Card(
                title: "Personal Information",
                subtitle: "Tell us about yourself",
                style: FormCard.CardStyle(
                    backgroundColor: Color(.systemBackground),
                    cornerRadius: 16,
                    shadowRadius: 4,
                    padding: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                )
            ) {
                Column(spacing: 16) {
                    // Name row for responsive layout
                    Row(spacing: 12, alignment: .center) {
                        TextField("firstName")
                            .label("First Name")
                            .required()
                            .placeholder("John")
                            .minLength(2)
                        
                        TextField("lastName")
                            .label("Last Name")
                            .required()
                            .placeholder("Doe")
                            .minLength(2)
                    }
                    
                    TextField("email")
                        .label("Email Address")
                        .required()
                        .email()
                        .placeholder("john.doe@example.com")
                        .style(FieldStyle(
                            backgroundColor: Color.blue.opacity(0.05),
                            borderColor: .blue,
                            borderWidth: 1.5
                        ))
                    
                    DatePicker("birthDate")
                        .label("Date of Birth")
                        .required()
                        .maxDate(Date())
                }
            }
            
            Spacer(16)
            
            // Account Settings
            Card(
                title: "Account Settings",
                style: FormCard.CardStyle(
                    backgroundColor: Color(.secondarySystemBackground),
                    cornerRadius: 16,
                    shadowRadius: 2
                )
            ) {
                Column(spacing: 16) {
                    TextField("username")
                        .label("Username")
                        .required()
                        .placeholder("Choose a unique username")
                        .minLength(4)
                    
                    // Password fields with conditional validation message
                    TextField("password")
                        .label("Password")
                        .required()
                        .placeholder("Min 8 characters")
                        .minLength(8)
                    
                    TextField("confirmPassword")
                        .label("Confirm Password")
                        .required()
                        .placeholder("Re-enter password")
                    
                    Divider(color: .secondary.opacity(0.3))
                    
                    PickerField("accountType")
                        .label("Account Type")
                        .required()
                        .options(["Personal", "Business", "Developer"])
                }
            }
            
            Spacer(16)
            
            // Conditional Business Information
            ConditionalComponent(condition: { values in
                // This would check the actual form state
                values["accountType"]?.stringValue == "Business"
            }) {
                Card(
                    title: "Business Information",
                    style: FormCard.CardStyle(
                        backgroundColor: Color.orange.opacity(0.1),
                        borderColor: .orange,
                        borderWidth: 1
                    )
                ) {
                    Column(spacing: 16) {
                        TextField("companyName")
                            .label("Company Name")
                            .required()
                            .placeholder("Acme Inc.")
                        
                        TextField("taxId")
                            .label("Tax ID")
                            .placeholder("XX-XXXXXXX")
                        
                        PickerField("industry")
                            .label("Industry")
                            .options(["Technology", "Healthcare", "Finance", "Retail", "Other"])
                    }
                }
            }
            
            Spacer(16)
            
            // Preferences Section
            Card(title: "Preferences") {
                Column(spacing: 12) {
                    ToggleField("newsletter")
                        .label("Subscribe to newsletter")
                        .defaultValue(true)
                    
                    ToggleField("notifications")
                        .label("Enable push notifications")
                        .defaultValue(false)
                    
                    ToggleField("marketing")
                        .label("Receive marketing emails")
                        .defaultValue(false)
                    
                    Divider(color: .secondary.opacity(0.3))
                    
                    Text(
                        "You can change these preferences anytime in settings",
                        font: .caption,
                        color: .secondary
                    )
                }
            }
            
            Spacer(20)
            
            // Terms and Conditions
            Column(spacing: 8) {
                ToggleField("agreeToTerms")
                    .label("I agree to the Terms of Service")
                    .required()
                
                ToggleField("agreeToPrivacy")
                    .label("I agree to the Privacy Policy")
                    .required()
                
                Text(
                    "By creating an account, you acknowledge that you have read and understood our policies.",
                    font: .caption2,
                    color: .secondary
                )
            }
        }
    }
}
