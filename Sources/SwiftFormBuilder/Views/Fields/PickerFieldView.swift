//
//  PickerFieldView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct PickerFieldView: View {
    let field: PickerFormField
    @Environment(\.formStateManager) private var stateManager
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: String = ""
    @State private var validationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    @State private var isExpanded: Bool = false
    
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
            
            // Custom picker button for better styling
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(localValue.isEmpty ? "Select..." : localValue)
                        .foregroundColor(localValue.isEmpty ? .secondary : .primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(.secondary)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isExpanded)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color(.systemGray4), lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expandable options
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(field.options, id: \.self) { option in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                localValue = option
                                isExpanded = false
                                commitValue(option)
                            }
                        }) {
                            HStack {
                                Text(option)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if localValue == option {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                        .font(.caption)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(
                                localValue == option ? Color.blue.opacity(0.1) : Color.clear
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if option != field.options.last {
                            Divider()
                                .padding(.horizontal, 12)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemBackground))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                .transition(.asymmetric(
                    insertion: .opacity.combined(with: .scale(scale: 0.95, anchor: .top)),
                    removal: .opacity
                ))
            }
            
            // Validation messages
            if let result = validationResult, !result.isValid {
                ValidationErrorView(errors: result.errors)
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: validationResult?.isValid ?? false)
        .onAppear {
            initializeField()
        }
    }
    
    private func initializeField() {
        if !hasInitialized {
            if case .selection(let value) = stateManager.getValue(for: field.id) {
                localValue = value
            }
            validationResult = stateManager.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: String) {
        let fieldValue: FieldValue = value.isEmpty ? .none : .selection(value)
        stateManager.setValue(fieldValue, for: field.id)
        
        let result = validator.validate(field: field, value: fieldValue)
        withAnimation(.easeInOut(duration: 0.2)) {
            validationResult = result
        }
        stateManager.setValidationResult(result, for: field.id)
    }
}
