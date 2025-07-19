//
//  ToggleFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct ToggleFieldView: View {
    let field: ToggleFormField
    @Environment(\.formStateManager) private var stateManager
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: Bool = false
    @State private var validationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(field.label)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        if field.isRequired {
                            Text("*")
                                .foregroundColor(.red)
                                .font(.headline)
                        }
                    }
                }
                
                Spacer()
                
                Toggle("", isOn: $localValue)
                    .labelsHidden()
            }
            .padding(.vertical, 4)
            
            if let result = validationResult, !result.isValid {
                ValidationErrorView(errors: result.errors)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: validationResult?.isValid ?? false)
        .onChange(of: localValue) { newValue in
            guard hasInitialized else { return }
            
            commitValue(newValue)
        }
        .onAppear {
            initializeField()
        }
    }
    
    private func initializeField() {
        if !hasInitialized {
            if case .boolean(let value) = stateManager.getValue(for: field.id) {
                localValue = value
            } else {
                localValue = field.defaultValue
            }
            validationResult = stateManager.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: Bool) {
        stateManager.setValue(.boolean(value), for: field.id)
        
        let result = validator.validate(field: field, value: .boolean(value))
        withAnimation(.easeInOut(duration: 0.2)) {
            validationResult = result
        }
        stateManager.setValidationResult(result, for: field.id)
    }
}
