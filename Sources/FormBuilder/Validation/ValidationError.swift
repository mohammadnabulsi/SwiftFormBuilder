//
//  ValidationError.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

public enum ValidationError: Error, LocalizedError {
    case required
    case invalidEmail
    case minLength(Int)
    case maxLength(Int)
    case custom(String)
    
    public var errorDescription: String? {
        switch self {
        case .required: return "This field is required"
        case .invalidEmail: return "Please enter a valid email address"
        case .minLength(let length): return "Must be at least \(length) characters"
        case .maxLength(let length): return "Must be no more than \(length) characters"
        case .custom(let message): return message
        }
    }
}
