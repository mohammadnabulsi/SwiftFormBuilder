//
//  StepperFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import SwiftUI

struct StepperFieldView: View {
    let field: StepperFormField
    @Environment(\.formStateManager) private var stateManager
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: Double = 0
    @State private var validationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    
    private var displayValue: String {
        if let format = field.format {
            return String(format: format, localValue)
        } else {
            // Remove decimal places if it's a whole number
            if localValue.truncatingRemainder(dividingBy: 1) == 0 {
                return String(format: "%.0f", localValue)
            } else {
                return String(format: "%.2f", localValue)
            }
        }
    }
    
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
            
            // Stepper with custom display
            HStack {
                // Value display
                Text(displayValue)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.primary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(.systemGray6))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                
                Spacer()
                
                // Stepper control
                if let range = field.range {
                    Stepper("", value: $localValue, in: range, step: field.step)
                        .labelsHidden()
                        .onChange(of: localValue) { newValue in
                            commitValue(newValue)
                        }
                } else {
                    Stepper("", value: $localValue, step: field.step)
                        .labelsHidden()
                        .onChange(of: localValue) { newValue in
                            commitValue(newValue)
                        }
                }
            }
            
            // Validation messages (using local validation result)
            if let validationResult = validationResult,
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
            if case .number(let value) = stateManager.getValue(for: field.id) {
                localValue = value
            } else {
                localValue = field.defaultValue
                commitValue(localValue)
            }
            validationResult = stateManager.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: Double) {
        stateManager.setValue(.number(value), for: field.id)
        
        // Use FormValidator to validate locally
        validationResult = validator.validate(field: field, value: .number(localValue))
        // Also update the main form state validation
        stateManager.setValidationResult(validationResult, for: field.id)
    }
}
