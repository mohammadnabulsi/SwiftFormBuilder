//
//  FormFieldView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct FormFieldView: View {
    let field: any FormField
    @ObservedObject var formState: FormState
    @ObservedObject var validator: FormValidator
    
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
            
            // Field input
            fieldInput
            
            // Validation messages
            if let validationResult = formState.validationResults[field.id],
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
    }
    
    @ViewBuilder
    private var fieldInput: some View {
        switch field {
        case let textField as TextFormField:
            TextField(textField.placeholder ?? "", text: textBinding(for: field.id))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: formState.getValue(for: field.id)) { _, newValue in
                    validator.validate(field: field, value: newValue, in: formState)
                }
                
        case let dateField as DateFormField:
            DatePicker("", selection: dateBinding(for: field.id), displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .onChange(of: formState.getValue(for: field.id)) { _, newValue in
                    validator.validate(field: field, value: newValue, in: formState)
                }
                
        case let toggleField as ToggleFormField:
            Toggle("", isOn: boolBinding(for: field.id))
                .onAppear {
                    if formState.getValue(for: field.id) == .none {
                        formState.setValue(.boolean(toggleField.defaultValue), for: field.id)
                    }
                }
                
        case let pickerField as PickerFormField:
            Picker("", selection: stringBinding(for: field.id)) {
                Text("Select...").tag("")
                ForEach(pickerField.options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .onChange(of: formState.getValue(for: field.id)) { _, newValue in
                validator.validate(field: field, value: newValue, in: formState)
            }
            
        default:
            Text("Unsupported field type")
                .foregroundColor(.secondary)
        }
    }
    
    private func textBinding(for fieldId: String) -> Binding<String> {
        Binding(
            get: {
                formState.getValue(for: fieldId).stringValue
            },
            set: { newValue in
                formState.setValue(.text(newValue), for: fieldId)
            }
        )
    }
    
    private func dateBinding(for fieldId: String) -> Binding<Date> {
        Binding(
            get: {
                if case .date(let date) = formState.getValue(for: fieldId) {
                    return date
                }
                return Date()
            },
            set: { newValue in
                formState.setValue(.date(newValue), for: fieldId)
            }
        )
    }
    
    private func boolBinding(for fieldId: String) -> Binding<Bool> {
        Binding(
            get: {
                formState.getValue(for: fieldId).boolValue
            },
            set: { newValue in
                formState.setValue(.boolean(newValue), for: fieldId)
            }
        )
    }
    
    private func stringBinding(for fieldId: String) -> Binding<String> {
        Binding(
            get: {
                if case .selection(let value) = formState.getValue(for: fieldId) {
                    return value
                }
                return ""
            },
            set: { newValue in
                formState.setValue(.selection(newValue), for: fieldId)
            }
        )
    }
}
