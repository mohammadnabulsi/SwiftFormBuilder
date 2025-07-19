//
//  DateFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct DateFieldView: View {
    let field: DateFormField
    @Environment(\.formStateManager) private var stateManager
    @EnvironmentObject var validator: FormValidator
    
    @State private var localValue: Date = Date()
    @State private var validationResult: ValidationResult?
    @State private var hasInitialized: Bool = false
    
    private var fieldStyle: FieldStyle? {
        if let styledField = field as? StyledDateFormField {
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
                
                // Date picker with range
                DatePicker("", selection: $localValue, in: field.dateRange ?? Date.distantPast...Date.distantFuture, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .disabled(fieldStyle?.isDisabled == true)
                    .onChange(of: localValue) { newValue in
                        commitValue(newValue)
                    }
                    .padding(fieldStyle?.padding ?? EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                    .background(
                        RoundedRectangle(cornerRadius: fieldStyle?.cornerRadius ?? 8)
                            .fill(fieldStyle?.backgroundColor ?? Color.clear)
                    )
                
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
            .opacity(fieldStyle?.isDisabled == true ? 0.6 : 1.0)
            .onAppear {
                initializeField()
            }
        }
    }
    
    private func initializeField() {
        if !hasInitialized {
            if case .date(let date) = stateManager.getValue(for: field.id) {
                localValue = date
            }
            validationResult = stateManager.getValidationResult(for: field.id)
            hasInitialized = true
        }
    }
    
    private func commitValue(_ value: Date) {
        stateManager.setValue(.date(value), for: field.id)
        
        // Validate with slight delay for smoother UI
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let result = validator.validate(field: field, value: .date(value))
            withAnimation(.easeInOut(duration: 0.2)) {
                validationResult = result
            }
            stateManager.setValidationResult(result, for: field.id)
        }
    }
}
