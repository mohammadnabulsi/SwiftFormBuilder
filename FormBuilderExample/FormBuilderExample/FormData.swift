//
//  FormData.swift
//  FormBuilderExample
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import FormBuilder
import Foundation

struct FormData {
    private let values: [String: FieldValue]
    
    init(_ values: [String: FieldValue]) {
        self.values = values
    }
    
    func getString(_ key: String) -> String? {
        guard case .text(let value) = values[key] else { return nil }
        return value
    }
    
    func getBool(_ key: String) -> Bool? {
        guard case .boolean(let value) = values[key] else { return nil }
        return value
    }
    
    func getDate(_ key: String) -> Date? {
        guard case .date(let value) = values[key] else { return nil }
        return value
    }
    
    func getSelection(_ key: String) -> String? {
        guard case .selection(let value) = values[key] else { return nil }
        return value
    }
    
    func getNumber(_ key: String) -> Double? {
        guard case .number(let value) = values[key] else { return nil }
        return value
    }
}
