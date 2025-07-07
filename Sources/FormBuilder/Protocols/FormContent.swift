//
//  FormContent.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

protocol FormContent: FormComponent {
    var components: [any FormComponent] { get }
}
