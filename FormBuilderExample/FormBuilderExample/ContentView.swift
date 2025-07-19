//
//  ContentView.swift
//  SwiftFormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI
import SwiftFormBuilder

struct ContentView: View {
    @State private var showingBasicForm = false
    @State private var showingComprehensiveForm = false
    @State private var showingRegistrationForm = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Form Builder Demo")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Show Basic Form") {
                showingBasicForm = true
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button("Show Comprehensive Form") {
                showingComprehensiveForm = true
            }
            .buttonStyle(PrimaryButtonStyle())
            
            Button("Show Registration Form") {
                showingRegistrationForm = true
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .sheet(isPresented: $showingBasicForm) {
            BasicFormView()
        }
        .sheet(isPresented: $showingComprehensiveForm) {
            ComprehensiveFormView()
        }
        .sheet(isPresented: $showingRegistrationForm) {
            RegistrationFormView()
        }
    }
}

struct BasicFormView: View {
    @State private var showSuccessAlert = false
    @State private var isSubmitting = false
    @State private var formValues: [String: FieldValue] = [:]
    
    var body: some View {
        FormView(definition: BasicForm())
            .layout(.default) // Try .compact
            .behavior(.default) // Try .lenient
            .onSubmit { values in
                // Print all form values
                print("=== FORM SUBMISSION ===")
                for (key, value) in values.sorted(by: { $0.key < $1.key }) {
                    print("\(key): \(value.stringValue)")
                }
                print("=====================")
            }
            .onValidationChanged { isValid in
//                isFormValid = isValid
            }
            .onValueChanged { values in
                // Optional: React to value changes
                print("Form values changed: \(values.count) fields")
            }
    }
}

struct ComprehensiveFormView: View {
    @State private var showSuccessAlert = false
    @State private var isSubmitting = false
    @State private var formValues: [String: FieldValue] = [:]
    
    var body: some View {
        FormView(definition: ComprehensiveForm())
            .layout(.default) // Try .compact
            .behavior(.default) // Try .lenient
            .onSubmit { values in
                // Print all form values
                print("=== FORM SUBMISSION ===")
                for (key, value) in values.sorted(by: { $0.key < $1.key }) {
                    print("\(key): \(value.stringValue)")
                }
                print("=====================")
            }
            .onValidationChanged { isValid in
//                isFormValid = isValid
            }
            .onValueChanged { values in
                // Optional: React to value changes
                print("Form values changed: \(values.count) fields")
            }
    }
}

struct RegistrationFormView: View {
    @State private var showSuccessAlert = false
    @State private var isSubmitting = false
    @State private var formValues: [String: FieldValue] = [:]
    
    var body: some View {
        FormView(definition: RegistrationForm())
            .layout(FormLayout(
                contentPadding: EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
                backgroundColor: Color(.systemGroupedBackground),
                titleDisplayMode: .large,
                showSubmitButton: true
            ))
            .behavior(FormBehavior(
                validateOnSubmit: true,
                validateOnChange: true,
                disableSubmitWhenInvalid: true,
                preventSubmitWhenInvalid: true,
                autoScroll: true
            ))
            .onSubmit { values in
                handleFormSubmission(values)
            }
            .onValueChanged { values in
                formValues = values
                print("Form values changed: \(values.keys)")
            }
            .onValidationChanged { isValid in
                print("Form validation state: \(isValid)")
            }
            .disabled(isSubmitting)
            .overlay(
                Group {
                    if isSubmitting {
                        ProgressView("Creating account...")
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 10)
                    }
                }
            )
            .alert("Success!", isPresented: $showSuccessAlert) {
                Button("OK") {
                    // Reset form or navigate
                }
            } message: {
                Text("Your account has been created successfully.")
            } // Enable performance debugging
    }
    
    private func handleFormSubmission(_ values: [String: FieldValue]) {
        isSubmitting = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isSubmitting = false
            showSuccessAlert = true
            
            // Log submitted values
            print("=== Form Submission ===")
            for (key, value) in values {
                print("\(key): \(value.stringValue)")
            }
            print("=====================")
        }
    }
}

// MARK: - Custom Theme Configuration

extension FormView {
    func applyCustomTheme() -> some View {
        self
            .preferredColorScheme(.light)
            .tint(.blue)
            .scrollContentBackground(.hidden)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .previewDisplayName("Registration Form")
    }
}
