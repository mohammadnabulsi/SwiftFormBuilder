//
//  Enhanced FormView.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import SwiftUI

public struct FormView<Definition: FormDefinition>: View {
    let definition: Definition
    private var stateManager = FormStateManager()
    @StateObject private var validator = FormValidator()
    @State private var isFormValid = false
    @State private var isSubmitting = false
    private var layout: FormLayout
    private var behavior: FormBehavior
    public var onSubmit: (([String: FieldValue]) -> Void)?
    public var onValueChanged: (([String: FieldValue]) -> Void)?
    public var onValidationChanged: ((Bool) -> Void)?
    
    public init(
        definition: Definition,
        layout: FormLayout = .default,
        behavior: FormBehavior = .default
    ) {
        self.definition = definition
        self.layout = layout
        self.behavior = behavior
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(definition.body.components, id: \.id) { component in
                        FormComponentView(component: component)
                    }
                }
                .padding(layout.contentPadding)
                .environment(\.formStateManager, stateManager)
                .environmentObject(validator)
            }
            .background(layout.backgroundColor.ignoresSafeArea())
            .navigationTitle(definition.title)
            .navigationBarTitleDisplayMode(layout.titleDisplayMode)
            .toolbar {
                if layout.showSubmitButton {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(definition.submitButtonTitle) {
                            submitForm()
                        }
                        .buttonStyle(FormButtonStyle.primary)
                        .disabled(!isFormValid && behavior.disableSubmitWhenInvalid)
                        .opacity(isFormValid || !behavior.disableSubmitWhenInvalid ? 1.0 : 0.6)
                    }
                }
            }
        }
        .onReceive(stateManager.formValidityPublisher) { isValid in
            isFormValid = isValid
            onValidationChanged?(isValid)
        }
        .disabled(isSubmitting)
    }
    
    private func submitForm() {
        if behavior.validateOnSubmit {
            validateAllFields()
        }
        
        if isFormValid || !behavior.preventSubmitWhenInvalid {
            let values = stateManager.getAllValues()
            onSubmit?(values)
        }
    }
    
    private func validateAllFields() {
        let allFields = extractAllFields(from: definition.body.components)
        for field in allFields {
            let value = stateManager.getValue(for: field.id)
            let result = validator.validate(field: field, value: value)
            stateManager.setValidationResult(result, for: field.id)
        }
    }
    
    private func extractAllFields(from components: [any FormComponent]) -> [any FormField] {
        var fields: [any FormField] = []
        
        for component in components {
            if let field = component as? any FormField {
                fields.append(field)
            } else if let section = component as? FormSection {
                fields.append(contentsOf: section.allFields)
            } else if let row = component as? FormRow {
                fields.append(contentsOf: extractAllFields(from: row.components))
            } else if let column = component as? FormColumn {
                fields.append(contentsOf: extractAllFields(from: column.components))
            } else if let card = component as? FormCard {
                fields.append(contentsOf: extractAllFields(from: card.components))
            } else if let list = component as? FormList<AnyIdentifiable> {
                // Handle dynamic lists
                for item in list.items {
                    let itemComponent = list.itemBuilder(item)
                    if let field = itemComponent as? any FormField {
                        fields.append(field)
                    } else {
                        fields.append(contentsOf: extractAllFields(from: [itemComponent]))
                    }
                }
            }
        }
        
        return fields
    }
}

// MARK: - Builder Pattern Extensions
public extension FormView {
    func layout(_ layout: FormLayout) -> FormView {
        return FormView(definition: definition, layout: layout, behavior: behavior)
    }
    
    func behavior(_ behavior: FormBehavior) -> FormView {
        return FormView(definition: definition, layout: layout, behavior: behavior)
    }
    
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
    
    func onValidationChanged(_ handler: @escaping (Bool) -> Void) -> FormView {
        var copy = self
        copy.onValidationChanged = handler
        return copy
    }
}

public struct AnyIdentifiable: Identifiable {
    public let id: AnyHashable
    private let _base: Any
    
    public init<T: Identifiable>(_ base: T) {
        self.id = AnyHashable(base.id)
        self._base = base
    }
    
    public func `as`<T>(_ type: T.Type) -> T? {
        return _base as? T
    }
}
