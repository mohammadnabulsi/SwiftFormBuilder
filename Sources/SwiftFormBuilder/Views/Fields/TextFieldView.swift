//
//  TextFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI
import Combine

struct TextFieldView: View {
    let field: TextFormField
    @Environment(\.formStateManager) private var stateManager
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: String = ""
    @State private var validationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    @State private var debounceTimer: Timer?
    @FocusState private var isFocused: Bool
    
    // For styled fields
    private var fieldStyle: FieldStyle? {
        if let styledField = field as? StyledTextFormField {
            return styledField.style
        }
        return nil
    }
    
    var body: some View {
        if fieldStyle?.isHidden == true {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 8) {
                // Field label
                HStack {
                    Text(field.label)
                        .font(fieldStyle?.labelFont ?? .headline)
                        .foregroundColor(fieldStyle?.labelColor ?? .primary)
                    
                    if field.isRequired {
                        Text("*")
                            .foregroundColor(.red)
                            .font(.headline)
                    }
                    
                    Spacer()
                }
                
                // Text field input with styling
                TextField(field.placeholder ?? "", text: $localValue)
                    .textFieldStyle(CustomTextFieldStyle(
                        backgroundColor: fieldStyle?.backgroundColor,
                        borderColor: fieldStyle?.borderColor,
                        borderWidth: fieldStyle?.borderWidth,
                        cornerRadius: fieldStyle?.cornerRadius,
                        padding: fieldStyle?.padding
                    ))
                    .disabled(fieldStyle?.isDisabled == true)
                    .focused($isFocused)
                    .onChange(of: localValue) { newValue in
                        handleValueChange(newValue)
                    }
                    .onSubmit {
                        // Validate immediately on submit
                        debounceTimer?.invalidate()
                        handleValueCommit(localValue)
                        validateField()
                    }
                
                // Validation messages with animation
                if let result = validationResult, !result.isValid {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(result.errors, id: \.localizedDescription) { error in
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                
                                Text(error.localizedDescription)
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity
                    ))
                }
            }
            .animation(.easeInOut(duration: 0.2), value: validationResult?.isValid ?? false)
            .opacity(fieldStyle?.isDisabled == true ? 0.6 : 1.0)
            .onAppear {
                initializeField()
            }
            .onDisappear {
                debounceTimer?.invalidate()
            }
        }
    }
    
    private func initializeField() {
        if !hasInitialized {
            // Get initial value from form state
            if case .text(let value) = stateManager.getValue(for: field.id) {
                localValue = value
            }
            
            // Get initial validation state
            validationResult = stateManager.getValidationResult(for: field.id)
            
            hasInitialized = true
        }
    }
    
    private func handleValueChange(_ newValue: String) {
        // Cancel previous validation timer
        debounceTimer?.invalidate()
        
        // Debounce validation (300ms delay)
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            Task { @MainActor in self.validateField() }
        }
    }
    
    private func handleValueCommit(_ newValue: String) {
        // Store value immediately
        stateManager.setValue(.text(newValue), for: field.id)
        
        // Cancel previous validation timer
        debounceTimer?.invalidate()
        
        // Debounce validation (300ms delay)
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            Task { @MainActor in self.validateField() }
        }
    }
    
    private func validateField() {
        let result = validator.validate(field: field, value: .text(localValue))
        
        withAnimation(.easeInOut(duration: 0.2)) {
            validationResult = result
        }
        
        stateManager.setValidationResult(result, for: field.id)
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    var backgroundColor: Color?
    var borderColor: Color?
    var borderWidth: CGFloat?
    var cornerRadius: CGFloat?
    var padding: EdgeInsets?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(padding ?? EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            .background(
                RoundedRectangle(cornerRadius: cornerRadius ?? 8)
                    .fill(backgroundColor ?? Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius ?? 8)
                    .strokeBorder(
                        borderColor ?? Color(.systemGray4),
                        lineWidth: borderWidth ?? 1
                    )
            )
    }
}
