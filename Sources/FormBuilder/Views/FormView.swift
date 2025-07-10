//
//  FormView.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

public struct FormView<Definition: FormDefinition>: View {
    let definition: Definition
    @StateObject private var formState = FormState()
    @StateObject private var validator = FormValidator()
    
    public var onSubmit: (([String: FieldValue]) -> Void)?
    public var onValueChanged: (([String: FieldValue]) -> Void)?
    
    public init(definition: Definition) {
        self.definition = definition
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(definition.body.components, id: \.id) { component in
                        viewComponent(component: component)
                    }
                }
                .padding()
                .environmentObject(formState)
                .environmentObject(validator)
            }
            .navigationTitle(definition.title)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(definition.submitButtonTitle) {
                        submitForm()
                    }
                    .disabled(!formState.isValid)
                }
            }
        }
    }
    
    @ViewBuilder
    private func viewComponent(component: any FormComponent) -> some View {
        if let section = component as? FormSection {
            FormSectionView(
                section: section
            )
        } else {
            FormComponentView(
                component: component
            )
        }
    }
    
    private func submitForm() {
//        let allFields = definition.body.components.compactMap { $0 as? (any FormField) }
//        validator.validateAll(fields: allFields, in: formState)
//        
//        if formState.isValid {
//            formState.isSubmitting = true
//            
//            // Call completion handler with form values
//            onSubmit?(formState.values)
//            
//            // Simulate async submission
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                formState.isSubmitting = false
//            }
//        }
    }
}

public extension FormView {
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
