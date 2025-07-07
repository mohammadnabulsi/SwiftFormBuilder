//
//  FieldValue.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

enum FieldValue: Codable, Equatable {
    case text(String)
    case number(Double)
    case boolean(Bool)
    case date(Date)
    case selection(String)
    case multiSelection([String])
    case none
    
    var stringValue: String {
        switch self {
        case .text(let value): return value
        case .number(let value): return String(value)
        case .boolean(let value): return String(value)
        case .date(let value): return DateFormatter().string(from: value)
        case .selection(let value): return value
        case .multiSelection(let values): return values.joined(separator: ", ")
        case .none: return ""
        }
    }
    
    var boolValue: Bool {
        switch self {
        case .boolean(let value): return value
        case .text(let value): return !value.isEmpty
        case .none: return false
        default: return true
        }
    }
}
