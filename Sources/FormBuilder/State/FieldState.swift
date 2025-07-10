//
//  FieldState 2.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Combine

class FieldState: ObservableObject {
    let id: String
    @Published var value: FieldValue = .none
    @Published var validationResult: ValidationResult?
    
    init(id: String) {
        self.id = id
    }
}
