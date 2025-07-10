//
//  FormDefinition.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

public protocol FormDefinition {
    var title: String { get }
    var submitButtonTitle: String { get }
    @FormComponentBuilder var body: any FormContent { get }
}
