//
//  TextFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct TextFieldView: View {
    let field: TextFormField
    @EnvironmentObject var formState: FormState
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: String = ""
    @State private var localValidationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Field label
            HStack {
                Text(field.label)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if field.isRequired {
                    Text("*")
                        .foregroundColor(.red)
                        .font(.headline)
                }
                
                Spacer()
            }
            
            // Text field input
            TextField(field.placeholder ?? "", text: $localValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
                .onSubmit {
                    commitValue()
                }
                .onChange(of: localValue) { _, focused in
                    commitValue()
                }
            
            // Validation messages (using local validation result)
            if let validationResult = localValidationResult,
               !validationResult.isValid {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(validationResult.errors, id: \.localizedDescription) { error in
                        Text(error.localizedDescription)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .onAppear {
            initializeLocalState()
        }
    }
    
    private func initializeLocalState() {
        if !hasInitialized {
            localValue = formState.getValue(for: field.id).stringValue
            localValidationResult = formState.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue() {
        formState.setValue(.text(localValue), for: field.id)
        
        // Create a temporary form state for local validation
        let tempFormState = FormState()
        tempFormState.setValue(.text(localValue), for: field.id)
        
        // Use FormValidator to validate locally
        localValidationResult = validator.validate(field: field, value: .text(localValue))
        // Also update the main form state validation
        formState.setValidationResult(localValidationResult, for: field.id)
    }
}
