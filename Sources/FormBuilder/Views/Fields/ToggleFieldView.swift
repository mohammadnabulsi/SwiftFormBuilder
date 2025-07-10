//
//  ToggleFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct ToggleFieldView: View {
    let field: ToggleFormField
    @EnvironmentObject var formState: FormState
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: Bool = false
    @State private var localValidationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Toggle with label
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
                
                Toggle("", isOn: $localValue)
                    .onChange(of: localValue) { _, newValue in
                        commitValue(newValue)
                    }
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
            if case .boolean(let value) = formState.getValue(for: field.id) {
                localValue = value
            } else {
                localValue = field.defaultValue
                commitValue(localValue)
            }
            localValidationResult = formState.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: Bool) {
        formState.setValue(.boolean(value), for: field.id)
        
        // Create a temporary form state for local validation
        let tempFormState = FormState()
        tempFormState.setValue(.boolean(value), for: field.id)
        
        // Use FormValidator to validate locally
        localValidationResult = validator.validate(field: field, value: .boolean(localValue))
        // Also update the main form state validation
        formState.setValidationResult(localValidationResult, for: field.id)
    }
}
