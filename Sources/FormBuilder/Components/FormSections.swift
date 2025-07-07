//
//  FormSections.swift
//  FormBuilder
//
//  Created by Mohammad Nabulsi on 07.07.25.
//

import Foundation

struct FormComponents: FormContent {
    let id: String = UUID().uuidString
    let components: [any FormComponent]
    
    init(@FormComponentBuilder components: () -> [any FormComponent]) {
        self.components = components()
    }
}
