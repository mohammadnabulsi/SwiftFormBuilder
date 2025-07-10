//
//  FormStateManager.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Combine
import SwiftUICore

/// Non-observable state manager that doesn't trigger view updates
class FormStateManager {
    private var fieldStates: [String: FieldState] = [:]
    private var valuesCache: [String: FieldValue] = [:]
    
    let formValidityPublisher = PassthroughSubject<Bool, Never>()
    let formValueChangedPublisher = PassthroughSubject<[String: FieldValue], Never>()
    
    func getFieldState(for id: String) -> FieldState {
        if let existing = fieldStates[id] {
            return existing
        }
        let newState = FieldState(id: id)
        fieldStates[id] = newState
        return newState
    }
    
    func setValue(_ value: FieldValue, for fieldId: String) {
        valuesCache[fieldId] = value
        fieldStates[fieldId]?.value = value
        
        formValueChangedPublisher.send(valuesCache)
    }
    
    func getValue(for fieldId: String) -> FieldValue {
        return valuesCache[fieldId] ?? .none
    }
    
    func getAllValues() -> [String: FieldValue] {
        return valuesCache
    }
    
    func setValidationResult(_ result: ValidationResult?, for fieldId: String) {
        fieldStates[fieldId]?.validationResult = result
        checkFormValidity()
    }
    
    func getValidationResult(for fieldId: String) -> ValidationResult? {
        fieldStates[fieldId]?.validationResult
    }
    
    private func checkFormValidity() {
        let isValid = fieldStates.values.allSatisfy { state in
            state.validationResult?.isValid ?? true
        }
        formValidityPublisher.send(isValid)
    }
}

private struct FormStateManagerKey: @preconcurrency EnvironmentKey {
    @MainActor
    static let defaultValue = FormStateManager()
}

extension EnvironmentValues {
    var formStateManager: FormStateManager {
        get { self[FormStateManagerKey.self] }
        set { self[FormStateManagerKey.self] = newValue }
    }
}
