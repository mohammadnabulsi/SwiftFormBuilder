//
//  ContentView.swift
//  FormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI
import FormBuilder

// MARK: - Usage Example in ContentView
struct ContentView: View {
    @State private var showingForm = false
    @State private var submittedValues: [String: FieldValue] = [:]
    @State private var isFormValid = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Form Builder Demo")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("Show Comprehensive Form") {
                showingForm = true
            }
            .buttonStyle(PrimaryButtonStyle())
            
            if !submittedValues.isEmpty {
                Text("Form submitted! Check console for values.")
                    .foregroundColor(.green)
                    .font(.headline)
            }
            
            Text("Form is \(isFormValid ? "valid" : "invalid")")
                .foregroundColor(isFormValid ? .green : .red)
        }
        .padding()
        .sheet(isPresented: $showingForm) {
            FormView(definition: ComprehensiveForm())
                .layout(.default) // Try .compact
                .behavior(.default) // Try .lenient
                .onSubmit { values in
                    submittedValues = values
                    showingForm = false
                    
                    // Print all form values
                    print("=== FORM SUBMISSION ===")
                    for (key, value) in values.sorted(by: { $0.key < $1.key }) {
                        print("\(key): \(value.stringValue)")
                    }
                    print("=====================")
                }
                .onValidationChanged { isValid in
                    isFormValid = isValid
                }
                .onValueChanged { values in
                    // Optional: React to value changes
                    print("Form values changed: \(values.count) fields")
                }
        }
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
