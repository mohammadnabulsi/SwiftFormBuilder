//
//  FormView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

struct FormView<Definition: FormDefinition>: View {
    let definition: Definition
    @StateObject private var formState = FormState()
    @StateObject private var validator = FormValidator()
    
    var onSubmit: (([String: FieldValue]) -> Void)?
    var onValueChanged: (([String: FieldValue]) -> Void)?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(definition.body.components, id: \.id) { component in
                        viewComponent(component: component)
                    }
                }
                .padding()
            }
            .navigationTitle(definition.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(definition.submitButtonTitle) {
                        submitForm()
                    }
                    .disabled(!formState.isValid || formState.isSubmitting)
                }
            }
        }
    }
    
    @ViewBuilder
    private func viewComponent(component: any FormComponent) -> some View {
        if let section = component as? FormSection {
            FormSectionView(
                section: section,
                formState: formState,
                validator: validator
            )
        } else {
            FormComponentView(component: component, formState: formState, validator: validator)
        }
    }
    
    private func submitForm() {
//        let allFields = definition.body.sections.flatMap { $0.fields }
//        validator.validateAll(fields: allFields, in: formState)
//        
//        if formState.isValid {
//            formState.isSubmitting = true
//            
//            // Call completion handler with form values
//            onSubmit?(formState.values)
//            
//            // Handle form submission
//            print("Form submitted with values: \(formState.values)")
//            
//            // Simulate async submission
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                formState.isSubmitting = false
//            }
//        }
    }
}

extension FormView {
    func onSubmit(_ handler: @escaping ([String: FieldValue]) -> Void) -> FormView {
        var copy = self
        copy.onSubmit = handler
        return copy
    }
    
    func onValueChanged(_ handler: @escaping ([String: FieldValue]) -> Void) -> FormView {
        var copy = self
        copy.onValueChanged = handler
        return copy
    }
}
