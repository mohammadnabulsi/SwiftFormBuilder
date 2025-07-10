//
//  DateFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct DateFieldView: View {
    let field: DateFormField
    @EnvironmentObject var formState: FormState
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: Date = Date()
    @State private var localValidationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    
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
            
            // Date picker input
            DatePicker("", selection: $localValue, displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .onChange(of: localValue) { _, newValue in
                    commitValue(newValue)
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
            if case .date(let date) = formState.getValue(for: field.id) {
                localValue = date
            }
            localValidationResult = formState.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: Date) {
        formState.setValue(.date(value), for: field.id)
        
        // Create a temporary form state for local validation
        let tempFormState = FormState()
        tempFormState.setValue(.date(value), for: field.id)
        // Use FormValidator to validate locally
        localValidationResult = validator.validate(field: field, value: .date(localValue))
        // Also update the main form state validation
        formState.setValidationResult(localValidationResult, for: field.id)
    }
}
