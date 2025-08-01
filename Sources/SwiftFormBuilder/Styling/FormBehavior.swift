//
//  FormBehavior.swift
//  SwiftFormBuilder
//
//  Created by Mohammad Nabulsi on 10.07.25.
//

import Foundation

public struct FormBehavior: Sendable {
    public var validateOnSubmit: Bool
    public var validateOnChange: Bool
    public var disableSubmitWhenInvalid: Bool
    public var preventSubmitWhenInvalid: Bool
    public var autoScroll: Bool
    
    public init(
        validateOnSubmit: Bool = true,
        validateOnChange: Bool = true,
        disableSubmitWhenInvalid: Bool = true,
        preventSubmitWhenInvalid: Bool = true,
        autoScroll: Bool = false
    ) {
        self.validateOnSubmit = validateOnSubmit
        self.validateOnChange = validateOnChange
        self.disableSubmitWhenInvalid = disableSubmitWhenInvalid
        self.preventSubmitWhenInvalid = preventSubmitWhenInvalid
        self.autoScroll = autoScroll
    }
    
    public static let `default` = FormBehavior()
    public static let lenient = FormBehavior(
        disableSubmitWhenInvalid: false,
        preventSubmitWhenInvalid: false
    )
}
