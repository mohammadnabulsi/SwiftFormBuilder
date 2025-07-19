//
//  BasicForm.swift
//  SwiftFormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftFormBuilder

struct BasicForm: FormDefinition {
    var title: String { "Enhanced Form" }
    var submitButtonTitle: String { "Submit" }
    
    var body: any FormContent {
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
            
            
            Section("Personal Information") {
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
